//
//  DataManager.swift
//  FahadDeVCrewAssignment
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let CITY_ENTITY = "City"
class CoreDataManager {
    var managedContext : NSManagedObjectContext?
    
    init(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
           }
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveCity(cities: CityListViewModel) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
           }
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CITY_ENTITY, in: context)!
        for eachCity in cities.values{
        let cityRef = NSManagedObject(entity: entity, insertInto: context)
        cityRef.setValue(eachCity.lat, forKeyPath: "lat")
        cityRef.setValue(eachCity.lon, forKeyPath: "lon")
        cityRef.setValue(eachCity.state, forKeyPath: "state")
        cityRef.setValue(eachCity.city, forKeyPath: "city")
        }
      do {
        try context.save()
        Global.shared.isDataSaved = true
        Global.shared.saveDefaults()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    
    func getCities() -> [CityModel]  {
        var cities: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return []
        }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: CITY_ENTITY)

        do {
          cities = try context.fetch(request)
            let result = cities.map { (model) -> CityModel in
                return CityModel(object: model)
            }
          return result
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func removeAllCitites()  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
               
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: CITY_ENTITY)
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(delete)
        } catch let _ as NSError {
        }
    }
}

    
