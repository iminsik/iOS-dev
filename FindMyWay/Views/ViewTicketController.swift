//
//  ViewTicketController.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/3/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import Foundation

//CocoaPods Libraries https://cocoapids.org
import UIKit
import SwiftyJSON
import PromiseKit
// Swift
import UserNotifications

extension Notification.Name {
    static let peru = Notification.Name("peru")
}

class ViewTicketController: UIViewController {
    @IBOutlet weak var TextViewPNR: UITextView!
    // Q: How can we secure username and password?
    let username: String = ""
    let password: String = ""
    static var scheduler : Timer?
    // Swift
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound];
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10,
                                                    repeats: false)


    fileprivate func ShowError(err: Error) -> Void {
        self.TextViewPNR.text = err.localizedDescription
    }
    
    @objc func AddRandomFlightToEntity() {
        // Do any additional setup after loading the view, typically from a nib.
        //let textPNR = UserDefaults.standard.string(forKey: "PNR")!
        
        let flightAwareSvc = FlightAwareService(self.username, self.password);
        
        flightAwareSvc.GetAirlineFlightSchedulesUntilTomorrow("KSEA", "KLAX", 30)
            .then(ParseAndShowFlights)
            .catch(ShowError)
        
        NotificationCenter.default.post(name: .peru, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddRandomFlightToEntity()
        
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.onDidReceiveData(notification:)), name: .peru, object: nil)
        
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Buy some milk"
        content.sound = UNNotificationSound.default
        
        // Swift
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })

        //        if ViewTicketController.scheduler == nil {
        //            ViewTicketController.scheduler = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(self.AddRandomFlightToEntity), userInfo: nil, repeats: true)
        //        }
        
    }

    @objc func onDidReceiveData(notification:Notification) {
        print("I got message from Peru!")
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Buy some milk"
        content.sound = UNNotificationSound.default
        
        // Swift
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })
    }
    
    fileprivate func PrintFlightInfoStatus(json: Any, response: PMKAlamofireDataResponse) -> Promise<Void>
    {
        let flightInfo : FlightInfo? = ConvertJsonToFlightStatusInfo(response)
        print(FlightInfoEntityRepository.Read())
        if (FlightInfoEntityRepository.Update(flightInfo!) == false) {
            FlightInfoEntityRepository.Create(flightInfo!)
        }
        self.TextViewPNR.text = FlightInfoEntityRepository.Read()

        return Promise()
    }
    
    fileprivate func ParseAndShowFlights(json: Any, response: PMKAlamofireDataResponse) -> Promise<Void>
    {
        let root : AirlineFlightSchedulesResultRoot? = self.ConvertJsonToAirlineFlightSchedule(response)
        let sortedFlights = self.sortFlightsByDepartureTimeInc(root!.airlineFlightSchedulesResult!.flights)
        
        let randIdx = Int.random(in: 0 ..< sortedFlights.count)
        FlightAwareService(self.username, self.password).GetFlightInfoStatus(ident: sortedFlights[randIdx].ident!)
            .then(PrintFlightInfoStatus)
            .catch(ShowError)

        return Promise()
    }

    fileprivate func ConvertJsonToAirlineFlightSchedule(_ response: PMKAlamofireDataResponse) -> AirlineFlightSchedulesResultRoot? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AirlineFlightSchedulesResultRoot.self, from: response.data!)
            //print(root!.airlineFlightSchedulesResult!.flights[0])
        } catch let err {
            print("Err", err)
        }
        return nil
    }
    
    fileprivate func ConvertJsonToFlightStatusInfo(_ response: PMKAlamofireDataResponse) -> FlightInfo? {
        do {
            var root : FlightInfoStatusResultRoot?
            let decoder = JSONDecoder()
            root = try decoder.decode(FlightInfoStatusResultRoot.self, from: response.data!)
            return root!.flightInfoStatusResult!.flights[0]
        } catch let err {
            print("Err", err)
        }
        return nil
    }
    
    fileprivate func sortFlightsByDepartureTimeInc(_ flights: [Flight] ) -> [Flight] {
        return flights.sorted(by: { $0.departureTime! < $1.departureTime! })
    }

    fileprivate func printToView(_ sortedFlights: [Flight]) {
        for flight in sortedFlights {
            self.TextViewPNR.text += NSDate(timeIntervalSince1970: TimeInterval(flight.departureTime!)).description.replacingOccurrences(of: "+0000", with: "") + " "
            self.TextViewPNR.text += flight.origin! + flight.destination! + " " + flight.aircrafttype! + "/" + flight.ident! + "\n"
        }
    }
}
