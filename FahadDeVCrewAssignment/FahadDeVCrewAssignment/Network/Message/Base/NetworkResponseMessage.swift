
import Foundation

enum StatusCode{
    case Success
    case Failure
    case Timeout
    //    case APISuccess
    //    case APIFailure
    //    case APITimeout
    
}
class NetworkResponseMessage{
    
    var statusCode: StatusCode
    var message: String
    var data: AnyObject?
    
    required init () {
        
        statusCode = StatusCode.Failure
        message = "Unknown error"
        
    }
    
    init ( statusCode: StatusCode,
           message : String,
           data: AnyObject? = nil) {
        
        self.statusCode = statusCode
        self.message = message
        self.data = data
    }
    
}
