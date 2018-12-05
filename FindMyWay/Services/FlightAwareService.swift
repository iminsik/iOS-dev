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
    
    func GetAirport(pnr: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Alamofire.request("https://httpbin.org/get").responseJSON()
    }
    
    func GetFlightInfoStatus(_ username: String, _ password: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Alamofire.request(FlightAwareService._baseURL + "/FlightInfoStatus?ident=ASA1388&include_ex_data=true")
            .authenticate(user: username, password: password)
            .responseJSON()
    }
}
