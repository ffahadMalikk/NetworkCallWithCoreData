
import Foundation
enum RequestType{
    case GET
    case POST
    case PUT
    case DELETE
    case HEAD
    case OPTIONS
}

enum ContentType{
    case HTML
    case JSON
}

class NetworkRequestMessage {
    
    var requestType: RequestType
    var contentType: ContentType
    var url: String
    var restMethod: String?
    var params: Dictionary<String, AnyObject>
    var paramsArray: [AnyObject]

    required init () {
        requestType = RequestType.GET
        contentType = ContentType.JSON
        url = ""
        restMethod = ""
        paramsArray = [AnyObject]()
        params = Dictionary<String, AnyObject>()
    }
    
    init (requestType: RequestType,
          contentType: ContentType,
          url: String,
          params: Dictionary<String, AnyObject>,
          restMethod: String? = nil,
         paramsArray : [AnyObject] = [AnyObject]()) {
        
        self.requestType = requestType
        self.contentType = contentType
        self.url = url
        self.restMethod = restMethod
        self.params = params
        self.paramsArray = paramsArray
    }
    
}
