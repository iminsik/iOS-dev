//
//  FlightAwareService.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/4/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class FlightAwareService {
    static let _baseURL : String = "https://flightxml.flightaware.com/json/FlightXML3"
    var username : String
    var password : String
    
    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
    }
    
    func GetAirport(pnr: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Alamofire.request("https://httpbin.org/get").responseJSON()
    }
    
    func GetFlightInfoStatus() -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Alamofire.request(FlightAwareService._baseURL + "/FlightInfoStatus?ident=ASA1388&include_ex_data=true")
            .authenticate(user: self.username, password: self.password)
            .responseJSON()
    }
    
    func GetAirlineFlightSchedulesUntilTomorrow (
//        _ origin: String?,
//        _ destination: String?,
//        _ airline: String?,
//        _ flightNo: String?,
//        _ exclude_codeshare: Bool?,
        howMany: Int?
//        _ offset: Int?
    ) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        let now = NSDate().timeIntervalSince1970
        let theDayAfterTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: Date())?.timeIntervalSince1970
        return Alamofire.request(FlightAwareService._baseURL + "/AirlineFlightSchedules?origin=KLAX&destination=KSEA&airline=ASA&start_date=" + String(format: "%d", NSInteger(now)) + "&end_date=" + String(format: "%d", NSInteger(theDayAfterTomorrow!)))
            .authenticate(user: self.username, password: self.password)
            .responseJSON()
    }
}
