//
//  CityModel.swift
//  FahadDeVCrewAssignment
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import Foundation

import CoreData
import SwiftyJSON
class CityModel {
    var lat:Double = 0
    var lon:Double = 0
    var state = ""
    var city = ""

     init() {
        self.lat = 0
        self.lon = 0
        self.state = ""
        self.city = ""
        
    }
     init(json : JSON){

        self.lat = json["lat"].double ?? 0
        self.lon = json["lon"].double ?? 0
        self.state = json["state"].string ?? ""
        self.city = json["city"].string ?? ""
    }
    init(object : NSManagedObject){
            self.lat = object.value(forKey: "lat") as! Double
           self.lon = object.value(forKey: "lon") as! Double
           self.state = object.value(forKey: "state") as! String
           self.city = object.value(forKey: "city") as! String
       }
    
}

class CityListViewModel {
    var values = [CityModel]()
    
    init() {
        self.values = [CityModel]()
    }
    
    convenience init(json : [JSON]){
        self.init()
        for each in json {
            self.values.append(CityModel(json: each))
        }
    }
}
