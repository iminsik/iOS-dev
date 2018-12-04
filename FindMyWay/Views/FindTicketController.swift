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
    var submitButtonColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButtonColor = submitButton.backgroundColor
        if ticketTextView.text == "" {
            submitButton.backgroundColor = UIColor.red
            submitButton.isEnabled = false
        } else {
            submitButton.backgroundColor = self.submitButtonColor
            submitButton.isEnabled = true
        }

    }
    
    @IBAction func SubmitTicket(_ sender: Any) {
    }
    
    
    @IBAction func TicketChangedRecently(_ sender: Any) {
        if ticketTextView.text == "" {
            submitButton.backgroundColor = UIColor.red
            submitButton.isEnabled = false
        } else {
            submitButton.backgroundColor = self.submitButtonColor
            submitButton.isEnabled = true
        }
    }
}

