
import Foundation

let STRING_SUCCESS = ""
let STRING_UNEXPECTED_ERROR = ""
let ERROR_NO_NETWORK = "Internet connection is currently unavailable."

public class BaseService : NSObject{
    
    public override init() {
        
    }
    
    func getValidationErrorResponseMessage (_ validationErrors: [String])->(ServiceResponseMessage) {
        
        let responseMessage = ServiceResponseMessage()
        responseMessage.serviceResponseType = ServiceResponseType.ValidationError
        responseMessage.validationErrors = validationErrors
        
        return responseMessage
    }
    
    func getSuccessResponseMessage (_ message:String = STRING_SUCCESS)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.Success
        svcResponse.message = message
        
        return svcResponse
    }
    
    func getErrorResponseMessage (_ message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.Failure
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse
    }
    
    func getDefaultServiceResponse(_ response: ParsedResponseMessage)-> (ServiceResponseMessage){

        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = response.serviceResponseType
        svcResponse.message = response.message

        return svcResponse
    }
    
    func getTimeoutErrorResponseMessage (_ message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.Timeout
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse;
    }
    
    func getServerErrorResponseMessage (_ message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.ServerError
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse
    }
    
    func getInternetErrorResponseMessage (_ message: AnyObject?)->(ServiceResponseMessage) {
        
        let svcResponse = ServiceResponseMessage()
        svcResponse.serviceResponseType = ServiceResponseType.NoInternetConnection
        
        if let messageText = message as? String {
            svcResponse.message = messageText
        } else {
            svcResponse.message = STRING_UNEXPECTED_ERROR
        }
        
        return svcResponse
    }
}
