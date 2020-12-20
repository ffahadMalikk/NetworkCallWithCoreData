//
//  SplashViewController.swift
//  DeVCrewAssignment
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import UIKit
import CoreData
class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !Global.shared.isDataSaved{
            self.getCities()
        }else{
            self.getCitiesFromCoreData()
        }
    }
    func getCities()  {
        let requestMessage = ServiceRequestMessage()
        let service = CityService()
        GCD.async(.Default) {
            service.getCities(requestMessage: requestMessage) { (serviceResponseMessage) in
                switch serviceResponseMessage.serviceResponseType {
                case .Success :
                    GCD.async(.Main) {
                        if let data = serviceResponseMessage.data as? CityListViewModel {
                            if !Global.shared.isDataSaved{
                                Global.shared.coreDataManager = CoreDataManager()
                                Global.shared.coreDataManager?.saveCity(cities: data)
                                self.getCitiesFromCoreData()
                            }
                        }
                    }
                case.Failure :
                    GCD.async(.Main) {
                        print("fail")
                    }
                default :
                    GCD.async(.Main) {
                        print("fail")
                    }
                }
            }
            GCD.async(.Main){
            }
        }
    }
    
    
    func getCitiesFromCoreData()  {
        var cities: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: CITY_ENTITY)
        
        do {
            cities = try context.fetch(request)
            let result = cities.map { (model) -> CityModel in
                return CityModel(object: model)
            }
            guard let vc = self.instantiateVC(withDestinationViewControllerType: CitiesViewController.self,andStoryboardName:StoryBoardNames.Main.rawValue) else { return }
            vc.source = result
            self.goTo(viewController: vc, withDisplayVCType: .push)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
}

