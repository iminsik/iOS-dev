//
//  ViewController.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/3/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import UIKit

class FindTicketController: UIViewController {
    @IBOutlet weak var ticketTextView: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var ticketValidationMsg: UITextView!
    
    var submitButtonColor: UIColor!
    var warningTicketNumberFormat = "Ticket # must be 6 Alphabets."

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        submitButtonColor = submitButton.backgroundColor
        if ticketTextView.text == "" {
            submitButton.backgroundColor = UIColor.red
            submitButton.isEnabled = false
        } else {
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func SubmitTicket(_ sender: Any) {
    }
    
    
    @IBAction func TicketChangedRecently(_ sender: Any) {
        if ticketTextView.text == "" {
            submitButton.backgroundColor = UIColor.red
            submitButton.isEnabled = false
        } else if IsValidTicketNumber(ticketTextView.text) {
            submitButton.backgroundColor = submitButtonColor
            submitButton.isEnabled = true
            ticketValidationMsg.text = ""
        }
        else {
            submitButton.backgroundColor = UIColor.red
            submitButton.isEnabled = false
            ticketValidationMsg.text = warningTicketNumberFormat
        }
    }
    
    func IsUppercasedAlphabet(_ character: Character) -> Bool {
        switch character {
            case "A"..."Z":
                return true
            default:
                return false
        }
    }
    
    func IsValidTicketNumber(_ ticketNumber: String?) -> Bool {
        var isValidTicketNumber = false
        if ticketNumber?.count == 6 {
            for character in ticketNumber! {
                isValidTicketNumber = IsUppercasedAlphabet(character)
            }
        }
        
        return isValidTicketNumber
    }
}

