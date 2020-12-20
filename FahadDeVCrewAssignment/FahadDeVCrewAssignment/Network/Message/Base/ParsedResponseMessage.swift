import SwiftyJSON

public class ParsedResponseMessage{
    var serviceResponseType: ServiceResponseType = .Failure
    var responseResultType: ResponseResultType = .Failure

    var data: AnyObject? = nil
    var exception: String? = nil
    var validationErrors: [String]? = nil
    var message = ""
    var swiftyJsonData: JSON? = nil
    init(message: String = "",responseResultType:ResponseResultType = .Failure, serviceResponseType:ServiceResponseType = .Failure, data:AnyObject? = nil, exception:String? = nil , validationErrors:[String]? = nil){
        self.serviceResponseType = serviceResponseType
        self.message = message
        self.data = data
        self.responseResultType = responseResultType
        self.exception = exception
        self.validationErrors = validationErrors
    }
}

