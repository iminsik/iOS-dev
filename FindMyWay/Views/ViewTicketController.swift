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

class ViewTicketController: UIViewController {
    @IBOutlet weak var TextViewPNR: UITextView!
    // Q: How can we secure username and password?
    let username: String = "kimate"
    let password: String = "6ea9e24e929403785d2f2bd99684a76fda3aed14"
    static var scheduler : Timer?

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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddRandomFlightToEntity()
        
        if ViewTicketController.scheduler == nil {
            ViewTicketController.scheduler = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(self.AddRandomFlightToEntity), userInfo: nil, repeats: true)
        }
    }

    fileprivate func PrintFlightInfoStatus(json: Any, response: PMKAlamofireDataResponse) -> Promise<Void>
    {
        let flightInfo : FlightInfo? = ConvertJsonToFlightStatusInfo(response)
        FlightInfoEntityRepository.Read()
        if (FlightInfoEntityRepository.Update(flightInfo!) == false) {
            FlightInfoEntityRepository.Create(flightInfo!)
        }
        FlightInfoEntityRepository.Read()

        return Promise()
    }
    
    fileprivate func ParseAndShowFlights(json: Any, response: PMKAlamofireDataResponse) -> Promise<Void>
    {
        var root : AirlineFlightSchedulesResultRoot?
        
        self.TextViewPNR.text = JSON(json).rawString()!
        self.ConvertJsonToAirlineFlightSchedule(&root, response)
        let sortedFlights = self.sortFlightsByDepartureTimeInc(root)
        self.printToView(sortedFlights)
        
        let randIdx = Int.random(in: 0 ..< sortedFlights.count)
        
        FlightAwareService(self.username, self.password).GetFlightInfoStatus(ident: sortedFlights[randIdx].ident!)
            .then(PrintFlightInfoStatus)
            .catch(ShowError)

        return Promise()
    }

    fileprivate func ConvertJsonToAirlineFlightSchedule(_ root: inout AirlineFlightSchedulesResultRoot?, _ response: PMKAlamofireDataResponse) {
        do {
            let decoder = JSONDecoder()
            root = try decoder.decode(AirlineFlightSchedulesResultRoot.self, from: response.data!)
            //print(root!.airlineFlightSchedulesResult!.flights[0])
            self.TextViewPNR.text = ""
        } catch let err {
            print("Err", err)
        }
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
    
    fileprivate func sortFlightsByDepartureTimeInc(_ root: AirlineFlightSchedulesResultRoot?) -> [Flight] {
        return root!.airlineFlightSchedulesResult!.flights.sorted(by: { $0.departureTime! < $1.departureTime! })
    }

    fileprivate func printToView(_ sortedFlights: [Flight]) {
        for flight in sortedFlights {
            self.TextViewPNR.text += NSDate(timeIntervalSince1970: TimeInterval(flight.departureTime!)).description.replacingOccurrences(of: "+0000", with: "") + " "
            self.TextViewPNR.text += flight.origin! + flight.destination! + " " + flight.aircrafttype! + "/" + flight.ident! + "\n"
        }
    }
}
