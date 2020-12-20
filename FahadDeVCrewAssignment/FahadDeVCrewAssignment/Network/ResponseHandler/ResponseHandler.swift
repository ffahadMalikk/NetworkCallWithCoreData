
import Foundation
import SwiftyJSON
let KEY_STATUS_TYPE = "code"
let KEY_RESULT_TYPE = "Status"
let KEY_EXCEPTION = "Exceptions"
let KEY_MESSAGE = "message"
let KEY_VALIDATION_ERROR = "ValidationErrors"
let KEY_DATA = "Response"

let ERROR_SERVER_NO_DATA = "Server didn't give response"
let ERROR_SERVER_WRONG_DATA = "Server didn't give proper response"
let NO_DATA_FOUND = "No data found"


class ResponseHandler {
    
    class func handleResponseStructure(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        
        let parsedResponse = ParsedResponseMessage()
        
        if let data = networkResponseMessage.data as? Data {
            
            do {
                let jsonDict = try JSON(data: data)
                    if let msg = jsonDict[KEY_MESSAGE].string{
                        parsedResponse.message = msg
                    }
                    
//                    switch resultType{
//
//                    case ServiceResponseType.Success.rawValue:
//                        
                        parsedResponse.responseResultType = .Success
                        parsedResponse.swiftyJsonData = jsonDict
                        parsedResponse.data = jsonDict as AnyObject
                        
//                    case ServiceResponseType.Failure.rawValue:
//                        parsedResponse.serviceResponseType = .Failure
//                        parsedResponse.swiftyJsonData = jsonDict
//
//                    case ServiceResponseType.DeActivated.rawValue:
//                        parsedResponse.serviceResponseType = .DeActivated
//
//                    case ServiceResponseType.Warning.rawValue:
//                        parsedResponse.serviceResponseType = .Warning
//
//                    case ServiceResponseType.Exception.rawValue:
//                        parsedResponse.serviceResponseType = .Exception
//                        if let exp = jsonDict[KEY_EXCEPTION].dictionary {
//                            parsedResponse.exception = exp.description
//                        }
//                        case ServiceResponseType.NoDataFound.rawValue:
//                            parsedResponse.responseResultType = .Success
//                            parsedResponse.swiftyJsonData = jsonDict
//                            parsedResponse.data = jsonDict as AnyObject
//                    default:
//                        parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                    }
        
                
                
            } catch _ {
                parsedResponse.message = ERROR_SERVER_WRONG_DATA
            }
        }
        else{
            parsedResponse.message = ERROR_SERVER_NO_DATA
        }
        
        return parsedResponse
    }
    
    
}

