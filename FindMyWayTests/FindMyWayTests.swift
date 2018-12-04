//
//  FindMyWayTests.swift
//  FindMyWayTests
//
//  Created by Insik Cho on 12/3/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import XCTest
@testable import FindMyWay

class FindMyWayTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsUppercasedAlphabet_AtoZ() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for uppercasedChar in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            let actual = FindTicketController.IsUppercasedAlphabet(uppercasedChar)
            XCTAssert(actual == true, String(format: String(uppercasedChar) + " must be an uppercase alphabet."))
        }
    }
    
    func testIsUppercasedAlphabet_atoz() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for uppercasedChar in "abcdefghijklmnopqrstuvwxyz" {
            let actual = FindTicketController.IsUppercasedAlphabet(uppercasedChar)
            XCTAssert(actual == false, String(format: String(uppercasedChar) + " must be an lowercase alphabet."))
        }
    }
    
    func testIsUppercasedAlphabet_notalphabets() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        for uppercasedChar in "123&*)_@#%" {
            let actual = FindTicketController.IsUppercasedAlphabet(uppercasedChar)
            XCTAssert(actual == false, String(format: String(uppercasedChar) + " is not  an alphabet."))
        }
    }
    
    func testIsValidTicketNumber_WhenValid_ReturnsTrue() {
        let ticketNumber = "ZXVCDF"
        let actual = FindTicketController.IsValidTicketNumber(ticketNumber)
        XCTAssert(actual == true, String(format: ticketNumber + " must be valid."))
    }
    
    func testIsValidTicketNumber_WhenNotValid_ReturnsFalse() {
        let ticketNumbers = ["ZXVCDZZ", "Z1c2fg", "11111"]
        for ticketNumber in ticketNumbers {
            let actual = FindTicketController.IsValidTicketNumber(ticketNumber)
            XCTAssert(actual == false, String(format: ticketNumber + " should not be valid."))
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
