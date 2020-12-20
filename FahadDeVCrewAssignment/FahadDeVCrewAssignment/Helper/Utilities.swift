//
//  Utilities.swift
//  DevcrewTask
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//


import Foundation
import UIKit

class Utilities
{
    class var shared : Utilities {
        
        struct Static {
            static let instance : Utilities = Utilities()
        }
        return Static.instance
        
    }
    func boolToString(value:Bool) -> String {
        return value ? "yes" : "no"
    }
    func randomNumber(MIN: Int, MAX: Int)-> Int{
        return Int(arc4random_uniform(UInt32(MAX - MIN + 1)) + UInt32(MIN));
    }
    
    func getDateFromString(date:String,givenFormat:String,requiredFormat:String) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        let newDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = requiredFormat
        let dateString : String = dateFormatter.string(from: newDate!)
        return dateString
    }
    
    func getDate() -> String  {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMMM dd,yyyy"
        let dateString : String = dateFormatter.string(from: date)
        return dateString
    }
    
    func isNumeric(string: String) -> Bool
    {
        let number = Int(string)
        return number != nil
    }

    func setRemovePlaceHolder(isEditing:Bool,textView:UITextView,placeHolder:String,placeHolderColor:UIColor,textColor:UIColor) {
        
        if !isEditing{
            if textView.text == ""{
                textView.text = placeHolder
                textView.textColor = placeHolderColor
            }else{
                textView.textColor = textColor
            }
        }else{
            
            if textView.textColor == placeHolderColor{
                textView.text = ""
                textView.textColor = textColor
            }else{
                
            }
            
        }
        
    }
    
    func isValidEmail(_ testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    func getJsonString(_ jsonObject: [[String: AnyObject]]) -> String {
        
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options:JSONSerialization.WritingOptions.prettyPrinted)
            
        } catch _ {
            /* TODO: Finish migration: handle the expression passed to error arg: error */
        }
        
        let jsonString = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
        
        return jsonString! as String
    }

}

