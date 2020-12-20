
import Foundation
import UIKit
extension Data {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.

    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8, allowLossyConversion: false) {
            append(data)
        }
    }
}

class BaseNetwork{
    
    private func configurePostRequest( request:inout NSMutableURLRequest,requestMessage:NetworkRequestMessage){
        
        request.httpMethod = "POST"
        
        if(requestMessage.contentType == ContentType.JSON){
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestMessage.params, options: .prettyPrinted)
                request.httpBody = jsonData
            } catch _ {
                /* TODO: Finish migration: handle the expression passed to error arg: error */
            }
            
            let responseInStringFormat : String = String(data: request.httpBody!, encoding: String.Encoding.utf8)!
            print("----- POST JSON Request -----")
            print("URL : \(String(describing: request.url))")
            print("BODY:  \(responseInStringFormat)")
            print("----- POST JSON Request -----")
        }else if requestMessage.contentType == ContentType.HTML {
            
            var queryString = ""
            
            for (key,value) in requestMessage.params {
                let valueString = "\(value)".htmlEncodedString()
                queryString = "\(queryString)\(key)=\(valueString)&"
            }
            if queryString.count > 0{
                
                if queryString.last == "&"{
                 queryString.removeLast()
                }
                
//                queryString = queryString.substring(to: queryString.endIndex)
                //queryString = queryString.substring(from: queryString.endIndex)// substringToIndex(queryString.endIndex.predecessor())
            }
            
            print("----- POST Request -----")
            print("URL : \(String(describing: request.url))")
            print("Query String : \(queryString)")
            print("----- POST Request -----")
            request.httpBody = queryString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
}
    private func configurePutRequest( request:inout NSMutableURLRequest,requestMessage:NetworkRequestMessage){
        
        request.httpMethod = "PUT"
        
        if(requestMessage.contentType == ContentType.JSON){
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestMessage.params, options: .prettyPrinted)
                request.httpBody = jsonData
            } catch _ {
                /* TODO: Finish migration: handle the expression passed to error arg: error */
            }
        }else if requestMessage.contentType == ContentType.HTML {
            
            var queryString = ""
            
            for (key,value) in requestMessage.params {
                let valueString = "\(value)".htmlEncodedString()
                queryString = "\(queryString)\(key)=\(valueString)&"
            }
            
            if queryString.count > 0{

                if queryString.last == "&"{
                    queryString.removeLast()
                }
                //queryString = queryString.substring(from: queryString.endIndex)// substringToIndex(queryString.endIndex.predecessor())
            }
            print("----- POST Request -----")
            print("URL : \(String(describing: request.url))")
            print("Query String : \(queryString)")
            print("----- POST Request -----")
            request.httpBody = queryString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
    }
    private func configureGetRequest(request:inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        request.httpMethod = "GET"
        var queryString = ""
        for (key,value) in requestMessage.params {
            let valueString = "\(value)".htmlEncodedString()
            queryString = "\(queryString)\(key)=\(valueString)&"
        }
        if queryString.count > 2{
            if queryString.last == "&"{
                queryString.removeLast()
            }
            //queryString = queryString.substringToIndex(queryString.endIndex.predecessor())
        }
        print(queryString)
        if queryString.count > 0 {
//            if let reallyURL = NSURL(string: requestMessage.url + "?" + queryString){
            if requestMessage.url.contains("?"){
                 request.url = URL(string: requestMessage.url + "&" + queryString)
            }else{
                request.url = URL(string: requestMessage.url + "?" + queryString)
            }
             //   request.url = reallyURL as URL
           // }
//            else{
//
//            }
        }
        print("----- GET Request -----")
        print("URL : \(String(describing: request.url))")
        print("Query String : \(queryString)")
        print("----- GET Request -----")
    }
    
    private func configureRequest (request:inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        
        switch requestMessage.requestType {
            
        case RequestType.GET:
            
            self.configureGetRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.POST:
            
            self.configurePostRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.PUT:
            
            self.configurePutRequest(request: &request, requestMessage: requestMessage)
            
        case RequestType.DELETE:
            
            request.httpMethod = "DELETE"
            
        case RequestType.HEAD:
            
            request.httpMethod = "HEAD"
            
        case RequestType.OPTIONS:
            
            request.httpMethod = "OPTIONS"
            
        }
    }
  
    private  func addTokenHeader (request:inout NSMutableURLRequest){
        
       // request.addValue(Global.shared.headerToken, forHTTPHeaderField: "Authorization")
        
    }
    private func addCustomHeaders(request:inout NSMutableURLRequest){
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
    }
    func performNetworkTask(isToken:Bool,requestMessage : NetworkRequestMessage, complete: @escaping ((_ responseMessage: NetworkResponseMessage)->Void)) {
        
        let responseMessage = NetworkResponseMessage()

        if let reallyURL = NSURL(string: requestMessage.url){
            var request = NSMutableURLRequest(url: reallyURL as URL)
            if isToken{
                self.addTokenHeader(request: &request)
            }
//            self.addCustomHeaders(request: &request)
            self.configureRequest(request: &request, requestMessage: requestMessage)
            
            let configuration = URLSessionConfiguration.default
           // configuration.timeoutIntervalForRequest = TimeInterval(90)
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (incomingData, response, error) in
                if let res = response as? HTTPURLResponse{
                if let err = error{
                    if res.statusCode == NSURLErrorTimedOut  {
                        responseMessage.statusCode = StatusCode.Timeout
                    } else {
                         responseMessage.statusCode = StatusCode.Failure
                    }
                    responseMessage.message = err.localizedDescription
                }else if let incomingData = incomingData {
                    let responseInStringFormat : String = String(data: incomingData, encoding: String.Encoding.utf8)!
                    print("----- Response -----")
                    print("\(responseInStringFormat)")
                    print("----- Response -----")
                    responseMessage.statusCode = StatusCode.Success
                    responseMessage.message = "Success"
                    responseMessage.data = incomingData as AnyObject?
                }
            }else{
                    responseMessage.statusCode = StatusCode.Timeout
                }
                complete(responseMessage)
            })
            task.resume()
        }
        //return responseMessage
    }
    private func configureMultiPartUploadRequest( request :inout NSMutableURLRequest , requestMessage : NetworkRequestMessage) {
        
        request.httpMethod = "POST"
        let parameeters = requestMessage.params
        
        let resizedImage = parameeters["image"] as! UIImage
        
        let boundary = generateBoundaryString()
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = resizedImage.jpegData(compressionQuality: 0.1) 
        if(imageData == nil){
            return
        }
        if requestMessage.contentType == ContentType.JSON {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: requestMessage.params, options:JSONSerialization.WritingOptions.prettyPrinted)
                
                request.httpBody = jsonData;
            } catch _ {
                /* TODO: Finish migration: handle the expression passed to error arg: error */
            }
        }
        else if requestMessage.contentType == ContentType.HTML {
            request.httpBody = self.createBodyWithParameters(parameters: parameeters, filePathKey: "image", imageDataKey: imageData!, boundary: boundary)
        }
    }
    func performUploadImageNetworkTask(requestMessage : NetworkRequestMessage, complete: @escaping ((_ responseMessage: NetworkResponseMessage)->Void))  {
        let responseMessage = NetworkResponseMessage()
        if let reallyURL = NSURL(string: requestMessage.url){
            var request = NSMutableURLRequest(url: reallyURL as URL)
            //self.addCustomHeaders(request: &request)
            //self.configureRequest(request: &request, requestMessage: requestMessage)
            //self.addTokenHeader(request: &request)
            self.configureMultiPartUploadRequest(request: &request, requestMessage: requestMessage)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (incomingData, response, error) in
                if let err = error{
                    if err.localizedDescription.contains("timed out"){
                        responseMessage.statusCode = StatusCode.Timeout
                    }else{
                        responseMessage.statusCode = StatusCode.Failure
                    }
                    responseMessage.message = err.localizedDescription
                }else if let incomingData = incomingData {
                    let res = response as! HTTPURLResponse
                    print("STATUSCODE: \(res.statusCode)")
                    print("RESPONSE :  \(String(data: incomingData, encoding: String.Encoding.utf8)!)" )
                    let responseInStringFormat : String = String(data: incomingData, encoding: String.Encoding.utf8)!
                    print("----- Response -----")
                    print("\(responseInStringFormat)")
                    print("----- Response -----")
                    
                    responseMessage.statusCode = StatusCode.Success
                    responseMessage.message = "Success"
                    responseMessage.data = incomingData as AnyObject?
                }
                complete(responseMessage)
                
            })
            
            task.resume()
        }
        
    }
    func createBodyWithParameters(parameters: [String: AnyObject]?, filePathKey: String, imageDataKey: Data, boundary: String) -> Data  {
        
        var body = Data()
        
        if parameters != nil {
            for (key, value) in parameters! {
                if key != "image" {
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.append("\(value)\r\n")
                }
            }
        }
        let filename = "propertyFile.jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        //print(body.base64EncodedString())
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}
