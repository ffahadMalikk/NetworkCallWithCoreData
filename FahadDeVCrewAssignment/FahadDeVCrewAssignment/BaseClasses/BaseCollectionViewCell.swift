//
//  BaseCollectionViewCell.swift
//  DevcrewTask
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import UIKit
import Foundation

class BaseCollectionViewCell: UICollectionViewCell {
    
    
    func createGradient(firstColor : UIColor,lastColor : UIColor) -> CAGradientLayer{
          
          let gradient = CAGradientLayer()

          gradient.frame = self.bounds
          gradient.colors = [firstColor.cgColor, lastColor.cgColor]
          gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
          gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
          
          
        //  var gradientLayerView: UIView = UIView(frame: CGRect.init(x: 0, y: 0, width: , height: <#T##CGFloat#>)(0, 0, view.bounds.width, 50))
       //   var gradient: CAGradientLayer = CAGradientLayer()
         // gradient.frame = gradientLayerView.bounds
        //  gradient.colors = [UIColor.grayColor().CGColor, UIColor.clearColor().CGColor]
         // gradientLayerView.layer.insertSublayer(gradient, atIndex: 0)
         // self.view.layer.insertSublayer(gradientLayerView.layer, atIndex: 0)
          return gradient

      }
    
}
