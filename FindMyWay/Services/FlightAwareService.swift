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
    static let _baseURL : String = "http://flightxml.flightaware.com/json/FlightXML3/"
    func GetAirport(pnr: String, completionHandler: @escaping (JSON) -> ()) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                return completionHandler(JSON(json))
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    func GetAirport(pnr: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Alamofire.request("https://httpbin.org/get").responseJSON()
    }
    
    func GetFlightInfoStatus(username: String, password: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
        return Alamofire.request(FlightAwareService._baseURL + "/FlightInfoStatus?ident=ASA1388&include_ex_data=true")
            .authenticate(user: username, password: password)
            .responseJSON()
    }
}
