//
//  FlightInfoEntityRepository.swift
//  FindMyWay
//
//  Created by Insik Cho on 12/5/18.
//  Copyright © 2018 Insik Cho. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FlightInfoEntityRepository {
    static func Update(_ flightInfo: FlightInfo) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let flightInfoEntity = NSFetchRequest<FlightInfoEntity>(entityName: "FlightInfoEntity")
        flightInfoEntity.predicate = NSPredicate(format: "flightNumber = %@", flightInfo.flightNumber!)
        
        do {
            let fetchedFlightInfoEntity = try managedContext.fetch(flightInfoEntity as! NSFetchRequest<NSFetchRequestResult>) as! [FlightInfoEntity]
            if(fetchedFlightInfoEntity.count > 0) {
                let managedObject = fetchedFlightInfoEntity[0]
                managedObject.setValue(flightInfo.cancelled, forKey: "cancelled")
                try managedContext.save()
                return true
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        return false
    }
    
    static func Remove() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let flightInfoEntity = NSFetchRequest<FlightInfoEntity>(entityName: "FlightInfoEntity")
        
        
        do {
            let fetchedFlightInfoEntity = try managedContext.fetch(flightInfoEntity as! NSFetchRequest<NSFetchRequestResult>) as! [FlightInfoEntity]
            
            for flightElm in fetchedFlightInfoEntity {
                managedContext.delete(flightElm)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    static func Read() -> String {
        var message : String = ""
        message += "---------- BEGIN: READ ----------\n"
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let flightInfoEntity = NSFetchRequest<FlightInfoEntity>(entityName: "FlightInfoEntity")
        
        do {
            let fetchedFlightInfoEntity = try managedContext.fetch(flightInfoEntity as! NSFetchRequest<NSFetchRequestResult>) as! [FlightInfoEntity]
            
            for flightInfoEntity in fetchedFlightInfoEntity {
                message += "\(flightInfoEntity.flightNumber!)/\(flightInfoEntity.cancelled)\n"
            }
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        message += "---------- END: READ ----------\n"
        return message
    }
    
    static func Create(_ flightInfo: FlightInfo) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let flightInfoEntity = NSEntityDescription.entity(forEntityName: "FlightInfoEntity", in: managedContext)!
        
        let flightInfoEntityObject = NSManagedObject(entity: flightInfoEntity, insertInto: managedContext)
        
        flightInfoEntityObject.setValue(flightInfo.flightNumber, forKey: "flightNumber")
        flightInfoEntityObject.setValue(flightInfo.cancelled, forKey: "cancelled")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
