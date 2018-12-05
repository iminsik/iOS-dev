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
    
    fileprivate func ShowError(err: Error) -> Void {
        self.TextViewPNR.text = err.localizedDescription
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let textPNR = UserDefaults.standard.string(forKey: "PNR")!
        
        let flightAwareSvc = FlightAwareService(self.username, self.password);
        flightAwareSvc.GetAirlineFlightSchedulesUntilTomorrow("KSEA", "KLAX", 30)
            .then(ParseAndShowFlights)
            .catch(ShowError)
    }
    
    fileprivate func ParseAndShowFlights(json: Any, response: PMKAlamofireDataResponse) -> Promise<Void>
    {
        var root : Root?
        
        self.TextViewPNR.text = JSON(json).rawString()!
        self.ConvertJsonToAirlineFlightSchedule(&root, response)
        let sortedFlights = self.sortFlightsByDepartureTimeInc(root)
        self.printToView(sortedFlights)
        
        return Promise()
    }

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
    
    fileprivate func sortFlightsByDepartureTimeInc(_ root: Root?) -> [Flight] {
        return root!.airlineFlightSchedulesResult!.flights.sorted(by: { $0.departureTime! < $1.departureTime! })
    }

    fileprivate func printToView(_ sortedFlights: [Flight]) {
        for flight in sortedFlights {
            self.TextViewPNR.text += NSDate(timeIntervalSince1970: TimeInterval(flight.departureTime!)).description.replacingOccurrences(of: "+0000", with: "") + " "
            self.TextViewPNR.text += flight.origin! + flight.destination! + " " + flight.aircrafttype! + "/" + flight.ident! + "\n"
        }
    }
}
