//
//  BaseViewController.swift
//  DevcrewTask
//
//  Created by Fahad on 20/12/2020.
//  Copyright © 2020 Fahad. All rights reserved.
//

import UIKit
import  Foundation


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    var snapshot: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillLayoutSubviews() {
    
        super.viewWillLayoutSubviews()
    }
    
    override open func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("memory warning received-- clearing")
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    public func instantiateVC<T>(withDestinationViewControllerType vcType: T.Type,
                                 andStoryboardName sbName: String = StoryBoardNames.Main.rawValue) -> T? where T: UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: sbName, bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: String(describing: vcType.self))
        return destinationVC as? T
    }
    public func goTo(viewController destinationVC: UIViewController,
              withDisplayVCType type: DisplayVCType = .push,
              andModalPresentationStyle style: UIModalPresentationStyle = .popover) {
        switch type {
        case .push:
            self.navigationController?.pushViewController(destinationVC, animated: true)
        case .present:
            destinationVC.modalPresentationStyle = .fullScreen
            self.present(destinationVC, animated: true, completion: nil)
        }
    }
    
}
