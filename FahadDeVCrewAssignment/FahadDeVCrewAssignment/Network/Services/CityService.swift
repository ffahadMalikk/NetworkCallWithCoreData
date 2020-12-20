//
//  CityService.swift
//  FahadDeVCrewAssignment
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import Foundation
import SwiftyJSON
public class CityService : BaseService {
    
    func getCities(requestMessage : ServiceRequestMessage, complete : @escaping((_ responseMessage : ServiceResponseMessage)-> Void)){
        
        let url = CITIES_URL
        let params = [String : Any]()
        
        let networkRequestMessage = NetworkRequestMessage.init(requestType: .GET, contentType: .JSON, url: url, params: params as Dictionary<String,AnyObject>)
        BaseNetwork().performNetworkTask(isToken: false, requestMessage: networkRequestMessage) { (networkResponseMessage) in
            switch networkResponseMessage.statusCode {
            case .Success :
                let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
                switch  parsedResponse.responseResultType {
                case .Success:
                    if let data = parsedResponse.swiftyJsonData {
                        let serviceResponse = self.getSuccessResponseMessage()
                        let tasks = CityListViewModel(json: data.array ?? [])
                        serviceResponse.data = tasks
                        complete(serviceResponse)
                    }
                    else{
                        let serviceResponse = self.getErrorResponseMessage("Error" as AnyObject)
                        // Global.shared.alertMessage = parsedResponse.message
                        complete(serviceResponse)
                    }
                default:
                    let serviceResponse = self.getErrorResponseMessage("Error" as AnyObject)
                    complete(serviceResponse)
                }
            case .Failure :
                let serviceResponse = self.getErrorResponseMessage("Error" as AnyObject)
                complete(serviceResponse)
                
            case .Timeout :
                let serviceResponse = self.getTimeoutErrorResponseMessage("Error" as AnyObject)
                complete(serviceResponse)
                
            }
        }
    }
}
