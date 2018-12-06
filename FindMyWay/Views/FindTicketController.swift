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
        
        if FlightInfoEntityRepository.ReadInfo() > 0 {
            let detailsViewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewTicket") as UIViewController
            let navigationController = UINavigationController(rootViewController: detailsViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func SubmitTicket(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(ticketTextView.text, forKey: "PNR")
    }
    
    @IBAction func TicketChangedRecently(_ sender: Any) {
        if ticketTextView.text == "" {
            submitButton.backgroundColor = UIColor.red
            submitButton.isEnabled = false
        } else if FindTicketController.IsValidTicketNumber(ticketTextView.text) {
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
    
    static func IsUppercasedAlphabet(_ character: Character) -> Bool {
        switch character {
            case "A"..."Z":
                return true
            default:
                return false
        }
    }
    
    static func AreAllAlphabets(_ ticketNumber: String) -> Bool {
        for index in ticketNumber.indices {
            if IsUppercasedAlphabet(ticketNumber[index]) == false {
                return false
            }
        }
        return true
    }
    
    static func IsValidTicketNumber(_ ticketNumber: String?) -> Bool {
        let ticketNumber = ticketNumber ?? ""
        return ticketNumber.count == 6 && AreAllAlphabets(ticketNumber)
    }
}

