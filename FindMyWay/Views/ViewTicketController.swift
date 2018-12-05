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
    
    fileprivate func ConvertJsonToAirlineFlightSchedule(_ root: inout Root?, _ response: PMKAlamofireDataResponse) {
        do {
            let decoder = JSONDecoder()
            root = try decoder.decode(Root.self, from: response.data!)
            print(root!.airlineFlightSchedulesResult!.flights[0])
            self.TextViewPNR.text = ""
        } catch let err {
            print("Err", err)
        }
    }
    
    fileprivate func printToView(_ sortedFlights: [Flight]) {
        for flight in sortedFlights {
            self.TextViewPNR.text += NSDate(timeIntervalSince1970: TimeInterval(flight.departureTime!)).description + " "
            self.TextViewPNR.text += flight.origin! + flight.destination! + " " + flight.aircrafttype! + "/" + flight.ident! + "\n"
        }
    }
    
    fileprivate func sortFlightsByDepartureTimeInc(_ root: Root?) -> [Flight] {
        return root!.airlineFlightSchedulesResult!.flights.sorted(by: { $0.departureTime! < $1.departureTime! })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let defaults = UserDefaults.standard
        //let textPNR = defaults.string(forKey: "PNR")!
        
        let flightAwareSvc = FlightAwareService(self.username, self.password);
        
        //https://learnappmaking.com/promises-swift-how-to/
        _ = flightAwareSvc.GetAirlineFlightSchedulesUntilTomorrow("KSEA", "KLAX", 10).then {
            (args) -> Promise<Void> in
            let (json, response) = args
            var root : Root?
            
            self.TextViewPNR.text = JSON(json).rawString()!
            self.ConvertJsonToAirlineFlightSchedule(&root, response)
            let sortedFlights = self.sortFlightsByDepartureTimeInc(root)
            self.printToView(sortedFlights)
            
            //print(self.TextViewPNR.text)
            return Promise()
        }.catch { (err) -> Void in
            self.TextViewPNR.text = err.localizedDescription
        }
    }
    
    func updateText(info: String){
        self.TextViewPNR.text = info
    }
}
