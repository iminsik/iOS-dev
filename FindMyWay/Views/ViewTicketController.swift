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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let defaults = UserDefaults.standard
        //let textPNR = defaults.string(forKey: "PNR")!
        
        let flightAwareSvc = FlightAwareService();
        
        //https://learnappmaking.com/promises-swift-how-to/
        _ = flightAwareSvc.GetFlightInfoStatus(self.username, self.password).then {
            (args) -> Promise<Void> in
            let (json, _) = args
            self.TextViewPNR.text = JSON(json).rawString()!
            return Promise()
        }.catch { (err) -> Void in
            self.TextViewPNR.text = err.localizedDescription
        }
    }
    
    func updateText(info: String){
        self.TextViewPNR.text = info
    }
}
