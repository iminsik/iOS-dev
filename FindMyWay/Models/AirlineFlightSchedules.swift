//
//  AirlineFlightSchedules.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/4/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import Foundation

struct AirlineFlightSchedules: Codable {
    
    let nextOffset: Int?
    let flights: Array<Flight>?
    
    private enum CodingKeys: String, CodingKey {
        case nextOffset = "next_offset"
        case flights
    }
}

struct Flight: Codable {
    let origin: String?
    let ident: String?
    let aircrafttype: String?
    let seatsCabinBusiness: Int?
    let destination: String?
    let arrivalTime: Int?
    let actualIdent: String?
    let mealService: String?
    let faIdent: String?
    let seatsCabinFirst: Int?
    let departureTime: Int?
    let seatsCabinCoach: Int?
    
    private enum CodingKeys: String, CodingKey {
        case origin
        case ident
        case aircrafttype
        case seatsCabinBusiness = "seats_cabin_business"
        case destination
        case arrivalTime = "arrivaltime"
        case actualIdent = "actual_ident"
        case mealService = "meal_service"
        case faIdent = "fa_ident"
        case seatsCabinFirst = "seats_cabin_first"
        case departureTime = "departuretime"
        case seatsCabinCoach = "seats_cabin_coach"
    }
}
