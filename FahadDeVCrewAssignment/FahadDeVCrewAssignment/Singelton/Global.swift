
import Foundation
class Global {

    
    var coreDataManager: CoreDataManager?
   
    class var shared : Global {
        
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
        
    }
    var isDataSaved: Bool = false
    func saveDefaults(){
        let defaults = UserDefaults.standard
        defaults.set(self.isDataSaved, forKey: defaultsKeys.dataSaved)
        defaults.synchronize()
    }
    func loadDefaults(){
      let  defaults = UserDefaults.standard
        if let dataSaved = defaults.bool(forKey: defaultsKeys.dataSaved) as? Bool{
            self.isDataSaved = dataSaved
        }
    }
    struct defaultsKeys {
        static let dataSaved = "dataSaved"
    }
}


