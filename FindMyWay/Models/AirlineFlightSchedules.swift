//
//  AirlineFlightSchedules.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/4/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import Foundation

//https://roadfiresoftware.com/2018/02/how-to-parse-json-with-swift-4/
struct AirlineFlightSchedulesResultRoot: Codable {
    let airlineFlightSchedulesResult: AirlineFlightSchedules?
    
    private enum CodingKeys: String, CodingKey {
        case airlineFlightSchedulesResult = "AirlineFlightSchedulesResult"
    }
}

struct FlightInfoStatusResultRoot: Codable {
    let flightInfoStatusResult: FlightInfoStatusResult?
    
    private enum CodingKeys: String, CodingKey {
        case flightInfoStatusResult = "FlightInfoStatusResult"
    }
}

struct FlightInfoStatusResult: Codable {
    let nextOffset: Int?
    let flights: [FlightInfo]

    private enum CodingKeys: String, CodingKey {
        case nextOffset = "next_offset"
        case flights
    }
}

struct Epoch: Codable {
    let epoch: Int?
    private enum CodingKeys: String, CodingKey {
        case epoch
    }
}

struct FlightTime: Codable {
    let date: String?
    let localTime: Int?
    let epoch: Int?
    let time: String?
    let dow: String?
    let tz: String?
    
    private enum CodingKeys: String, CodingKey {
        case date
        case localTime = "localtime"
        case epoch
        case time
        case dow
        case tz
    }
}

struct Airport: Codable {
    let city: String?
    let alternateIdent: String?
    let airportName: String?
    let code: String?
    private enum CodingKeys: String, CodingKey {
        case city
        case alternateIdent = "alternate_ident"
        case airportName = "airport_name"
        case code
    }
}


struct FlightInfo: Codable {
    let codeshares : String?
    let actualBlockoutTime : Epoch?
    let filedAirspeedKts : Int?
    let actualBlockinTime : Epoch?
    let departureDelay : Int?
    let progressPercent : Int?
    let aircraftType : String?
    let filedBlockoutTime : Epoch?
    let estimatedDepartureTime : FlightTime?
    let actualArrivalTime : Epoch?
    let distanceFiled : Int?
    let estimatedArrivalTime : FlightTime?
    let destination : Airport?
    let airlineIata : String?
    let adhoc : Bool?
    let filedDepartureTime : FlightTime?
    let flightNumber : String?
    let ident : String?
    let estimatedBlockinTime : Epoch?
    let diverted : Bool?
    let filedBlockinTime : Epoch?
    let status : String?
    let faFlightID : String?
    let type : String?
    let fullAircraftType : String?
    let blocked : Bool?
    let filedEte : Int?
    let estimatedBlockoutTime : Epoch?
    let origin : Airport?
    let arrivalDelay : Int?
    let actualDepartureTime : Epoch?
    let airline : String?
    let filedArrivalTime : FlightTime?
    let cancelled : Bool?
    
    private enum CodingKeys: String, CodingKey {
        case codeshares
        case actualBlockoutTime = "actual_blockout_time"
        case filedAirspeedKts = "filed_airspeed_kts"
        case actualBlockinTime = "actual_blockin_time"
        case departureDelay = "departure_delay"
        case progressPercent = "progress_percent"
        case aircraftType = "aircrafttype"
        case filedBlockoutTime = "filed_blockout_time"
        case estimatedDepartureTime = "estimated_departure_time"
        case actualArrivalTime = "actual_arrival_time"
        case distanceFiled = "distance_filed"
        case estimatedArrivalTime = "estimated_arrival_time"
        case destination
        case airlineIata = "airline_iata"
        case adhoc
        case filedDepartureTime = "filed_departure_time"
        case flightNumber = "flightnumber"
        case ident
        case estimatedBlockinTime = "estimated_blockin_time"
        case diverted
        case filedBlockinTime = "filed_blockin_time"
        case status
        case faFlightID
        case type
        case fullAircraftType = "full_aircrafttype"
        case blocked
        case filedEte = "filed_ete"
        case estimatedBlockoutTime = "estimated_blockout_time"
        case origin
        case arrivalDelay = "arrival_delay"
        case actualDepartureTime = "actual_departure_time"
        case airline
        case filedArrivalTime = "filed_arrival_time"
        case cancelled
    }

}

struct AirlineFlightSchedules: Codable {
    
    let nextOffset: Int?
    let flights: [Flight]
    
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

