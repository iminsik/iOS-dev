//
//  ViewTicketController.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/3/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ViewTicketController: UIViewController {
    @IBOutlet weak var TextViewPNR: UITextView!
    typealias MethodHandler1 = (String) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        let textPNR = defaults.string(forKey: "PNR")
        
        FlightAwareService().GetAirport(pnr: textPNR!){ (result) in
            self.TextViewPNR.text = result["origin"].stringValue
        }
        //TextViewPNR.text = textPNR
    }
    
    
    func updateText(info: String){
        self.TextViewPNR.text = info
    }
    //CocoaPods
    //https://cocoapids.org

}
