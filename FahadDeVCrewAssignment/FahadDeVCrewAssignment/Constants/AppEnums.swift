//
//  AppEnums.swift
//  DevcrewTask
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import Foundation

enum APICodes:Int
{
    case Success
    case Failure
    var rawValue: Int {
        switch self {
        case .Success: return 200
        case .Failure: return 100
        }
    }
    
}

enum DisplayVCType {
    case push
    case present
}

enum StoryBoardNames:String{
    case Main
}

enum TableViewCellNames:String{
    case CityTableViewCell
}
