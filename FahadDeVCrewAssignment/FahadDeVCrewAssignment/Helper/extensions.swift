//
//  UIColor+Utils.swift
//  DevcrewTask
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import Foundation
import UIKit

private var __maxLengths = [UITextField: Int]()

extension UITextField {
    
    
    
}


extension UIView {
        
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }


    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}


extension UITextField{
    

    
//    func setCustomClearIcon(){
//        let overlayButton = UIButton(type: .custom)
//        let bookmarkImage = UIImage(systemName: "clear")
//        overlayButton.setImage(bookmarkImage, for: .normal)
//        overlayButton.addTarget(self, action: #selector(clearTextFiled),
//            for: .touchUpInside)
//        overlayButton.sizeToFit()
//        self.rightView = overlayButton
//        self.leftViewMode = .always
//        self.clea
//    }
    @objc func clearTextFiled()  {
        self.clearTextFiled()
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String((t.prefix(maxLength)))
        }
    }
}


extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}


extension Date {
    var startOfWeek: Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        return saudi.date(from: saudi.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    var startOfMonth: Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        return saudi.date(from: saudi.dateComponents([.year, .month], from: self))!
    }
    
    var lastOfMonth: Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        return saudi.date(from: saudi.dateComponents([.year, .month], from: self))!
    }
    var startOfYear: Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        return saudi.date(from: saudi.dateComponents([.year], from: self))!
    }
    
    var startOfDay: Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        return saudi.startOfDay(for: self)
    }
    
    var daysOfWeek: [Date] {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        let startOfWeek = self.startOfWeek
        return (0...6).compactMap{ saudi.date(byAdding: .day, value: $0, to: startOfWeek)}
    }
    
    func lastDayOfMonth() -> Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        let dayRange = saudi.range(of: .day, in: .month, for: self)
        let dayCount = dayRange?.count
        var comp = saudi.dateComponents([.year, .month, .day], from: self)
        comp.day = dayCount
        return saudi.date(from: comp)!
    }
    
    func lastMonth(month: Int) -> Date {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        return saudi.date(byAdding: .month, value: month, to: self)!
    }
    
    func daysOfQuarterMonth(quarter: Int, month: Int) -> [Date] {
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        
        let monthDate = month == 0 ? self : self.lastMonth(month: month)
        let startOfWeek = monthDate.startOfMonth
        
        let dayRange = saudi.range(of: .day, in: .month, for: startOfWeek)
        let dayCount = dayRange?.count
        
        let start = quarter*10
        let end = quarter < 2 ? quarter*10 + 9 : dayCount!-1
        return (start...end).compactMap{ saudi.date(byAdding: .day, value: $0, to: startOfWeek)}
    }
    
    func daysOfWeek(_ weekNumb: Int) -> [Date]{
        var saudi = Calendar(identifier: Calendar.Identifier.gregorian)
        saudi.firstWeekday = 1
        saudi.locale = Locale(identifier: "en_US_POSIX")
        saudi.timeZone = TimeZone(identifier: "UTC")!
        let startOfWeek = self.startOfWeek.addingTimeInterval(TimeInterval((weekNumb)*7*24*60*60))
        return (0...6).compactMap{ saudi.date(byAdding: .day, value: $0, to: startOfWeek)}
    }
    var currentUTCTimeZoneDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameYear (date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameDay  (date: Date) -> Bool { isEqual(to: date, toGranularity: .day) }
    func isInSameWeek (date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    
    var isInThisYear:  Bool { isInSameYear(date: Date()) }
    var isInThisMonth: Bool { isInSameMonth(date: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(date: Date()) }
    
    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
    
    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
    
    func pastMonths(_ noOfMonths: Int, format: String = "MMM-yy") -> ([String], String) {
        let today = Date()
        let dates = (-noOfMonths...0).compactMap{ Calendar.current.date(byAdding: .month, value: $0, to: today)}.reversed()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let strings = dates.map{ dateFormatter.string(from: $0) }
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/YYYY"
        
        let periodStr = "\(dateFormatter2.string(from: dates.last!.startOfMonth)) - \(dateFormatter2.string(from: today))"
        
        return (strings, periodStr)
    }
    
    func pastPMonths(_ format: String = "MMM-yy") -> ([String], String) {
        let today = Date()
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "M"
        let currentMonthIndex = Int(dateFormatter1.string(from: today))! - 1
        let maxIndex = 12-currentMonthIndex-1
        
        let dates = (-currentMonthIndex...maxIndex).compactMap{ Calendar.current.date(byAdding: .month, value: $0, to: today)}.reversed()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let strings = dates.map{ dateFormatter.string(from: $0) }
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/YYYY"
        
        let periodStr = "\(dateFormatter2.string(from: today.startOfYear)) - \(dateFormatter2.string(from: today))"
        
        return (strings, periodStr)
    }
    
    
    
    func getMonthString(_ format: String = "MMM-yy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let string = dateFormatter.string(from: self)
        return string
    }
    
    func getWeeksString() -> [String] {
        var strings = [String]()
        
        let today = Date()
        let dates = (-2...0).compactMap{ Calendar.current.date(byAdding: .month, value: $0, to: today)}.reversed()

        let firstDate0 = dates.map({$0})[0].startOfMonth
        let firstDate1 = dates.map({$0})[1].startOfMonth
        let firstDate2 = dates.map({$0})[2].startOfMonth
        
        for index in 0..<12 {
            let weekDates = Date().daysOfWeek(-index)
            if weekDates.contains(firstDate0) {
                strings.append(firstDate0.getMonthString("MMM"))
            }else if weekDates.contains(firstDate1) {
                strings.append(firstDate1.getMonthString("MMM"))
            }else if weekDates.contains(firstDate2) {
                strings.append(firstDate2.getMonthString("MMM"))
            }else {
                strings.append("")
            }
        }
        
        return strings
    }
    
    func getThreeMonthsString() -> [String] {
        var strings = [String]()
        
        let today = Date()
        let dates = (-2...0).compactMap{ Calendar.current.date(byAdding: .month, value: $0, to: today)}.reversed()

        let firstDate0 = dates.map({$0})[0].startOfMonth
        let firstDate1 = dates.map({$0})[1].startOfMonth
        let firstDate2 = dates.map({$0})[2].startOfMonth
        
        var weeks = [[Date]]()
        
        let lastQuarter = Date().daysOfQuarterMonth(quarter: 2, month: 0)
        let secondlastQuarter = Date().daysOfQuarterMonth(quarter: 1, month: 0)
        let thirdlastQuarter = Date().daysOfQuarterMonth(quarter: 0, month: 0)
        if lastQuarter.contains(Date().startOfDay) {
            weeks.append(lastQuarter)
            weeks.append(secondlastQuarter)
            weeks.append(thirdlastQuarter)
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 0, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 0, month: -2))
        }else if secondlastQuarter.contains(Date().startOfDay) {
            weeks.append(secondlastQuarter)
            weeks.append(thirdlastQuarter)
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 0, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 0, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -3))
        }else if thirdlastQuarter.contains(Date().startOfDay) {
            weeks.append(thirdlastQuarter)
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 0, month: -1))
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 0, month: -2))
            weeks.append(Date().daysOfQuarterMonth(quarter: 2, month: -3))
            weeks.append(Date().daysOfQuarterMonth(quarter: 1, month: -3))
            
        }
        
        for index in 0..<weeks.count {
            let weekDates = weeks[index]
            if weekDates.contains(firstDate0) {
                strings.append(firstDate0.getMonthString("MMM"))
            }else if weekDates.contains(firstDate1) {
                strings.append(firstDate1.getMonthString("MMM"))
            }else if weekDates.contains(firstDate2) {
                strings.append(firstDate2.getMonthString("MMM"))
            }else {
                strings.append("")
            }
        }
        
        return strings
    }
    
}

extension UITextView{
    
    func addDoneButton() {
        let toolbar  = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done , target: self,action: #selector(self.hideKeyboard))
        toolbar.setItems([done], animated: true)
        self.inputAccessoryView = toolbar
        self.inputAccessoryView = toolbar
    }
    @objc func hideKeyboard()
    {
        self.endEditing(true)
    }
    
    
}

extension UITextField{
    func addDoneButton() {
        var buttonDone = UIBarButtonItem()
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(self.hideKeyboard), for: .touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        button.setTitle("Done", for: UIControl.State())
        button.setTitleColor(.black, for: UIControl.State())
        //button.titleLabel?.font = UIFont(name: , size: 20)
        button.contentMode = UIView.ContentMode.right
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        buttonDone = UIBarButtonItem(customView: button)
        toolbar.setItems(Array.init(arrayLiteral: buttonflexible,buttonDone), animated: true)
        self.inputAccessoryView = toolbar
        
    }
    @objc func hideKeyboard()
    {
        self.endEditing(true)
    }
}

extension UIButton {
  func underline() {
    let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
    self.setAttributedTitle(attributedString, for: .normal)
  }
}

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UITableView {
    
    func visibleCellsHeight() -> CGFloat {
        var height: CGFloat = 0
        for cell in self.visibleCells {
            height = height + cell.bounds.height
        }
        return height
    }
}

extension Bool{
    
    func toString() -> String {
        if self == true{
            return "true"
        }else{
            return "false"
        }
        
    }
    
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
public extension String{
    
    func stringByTrimingWhiteSpaces() -> String{
        return self.trimmingCharacters(in: .whitespaces)
    }
    

    
    func htmlEncodedString() -> String{
        if let str = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            return str
        }
        else{
            return self
        }
    }
    
    func urlWithoutSpace()-> String {
        let str = self.replacingOccurrences(of: " ", with: "%20")
        return str
    }
    
    static func convertStringToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func toBool() -> Bool?
    {
        switch self
        {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    
    
    
    func toDateFormatted(with dateFormat:String)-> NSDate? {
        let formator = DateFormatter()
        formator.dateFormat = dateFormat
        return formator.date(from: self) as NSDate?
    }
    
    
    func htmlAttributedString() -> NSMutableAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    
    func currencyInputFormatting(maxValue: String) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        //amountWithPrefix = amountWithPrefix.replacingOccurrences(of: ",", with: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        //let maxValueWithPrefix = regex.stringByReplacingMatches(in: maxValue, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, maxValue.count), withTemplate: "")
        //        if maxValue != "" {
        //            let maxValueWithPrefix = maxValue.replacingOccurrences(of: ",", with: "")
        //
        //            let doubleMaxValue = (maxValueWithPrefix as NSString).doubleValue
        //
        //            if double > doubleMaxValue {
        //                number = NSNumber(value: (doubleMaxValue))
        //
        //            }
        //
        //        }
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(99999))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat(99999), height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat(99999))
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
}
extension UIView {
    
    
    func setShadow()  {
        let radius: CGFloat = self.frame.width / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.0 * radius, height: self.frame.height))
        //Change 2.1 to amount of spread you need and for height replace the code for height
        
        self.layer.cornerRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0 //Here your control your blur
        self.layer.masksToBounds =  false
        self.layer.shadowPath = shadowPath.cgPath
    }
    func setShadow2(){
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        
    }
    func dropShadow2(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    
    
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIView {
    
    func setBorder(color:UIColor,borderWidth:CGFloat,cornerRadius:CGFloat)  {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        //bundle.loadNibNamed(nibName, owner: self, options: nil)
    }
    
    func customLoadFromNib(_ nibName: String) -> UIView{
        let bundle = Bundle.main
        //let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        //bundle.loadNibNamed(nibName, owner: self, options: nil)
    }
}



extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.12,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 38,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
    
    func string(_ fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
}

extension UIColor {
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()

        return label.frame.height
    }
}

extension Notification.Name {
    static let didgetToken = Notification.Name("didgetToken")
    static let firInstanceIDTokenRefresh = Notification.Name("Instance ID Token Refresh")
    static let didMoveToLead = Notification.Name("didMoveToLead")
    static let didMoveToApproval = Notification.Name("didMoveToApproval")
    static let didTapOnNotification = Notification.Name("didTapOnNotification")
    static let didRefreshLeads = Notification.Name("didRefreshLeads")
    static let didRefreshApproval = Notification.Name("didRefreshApproval")

}
extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
    
    
    
}
