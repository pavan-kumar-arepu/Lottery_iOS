//
//  ViewControllerUtils.swift
//  Lottery
//
//  Created by GuestUserLogin on 30/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorService {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(viewController: UIViewController) {
        guard let uiView = viewController.view else { return }
        container.frame = CGRect(x: 0, y: 0, width: uiView.frame.width, height: uiView.frame.height)
        container.backgroundColor = .clear
        
        loadingView.frame = CGRect.init(x: container.frame.size.width/2 - 40, y: container.frame.size.height/2 - 40, width: 80.0, height: 80.0)
        if let navigation = viewController.navigationController, !navigation.navigationBar.isHidden {
            loadingView.frame = CGRect.init(x: container.frame.size.width/2 - 40, y: container.frame.size.height/2 - 60, width: 80.0, height: 80.0)
        }
        //loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.backgroundColor = .clear
        //loadingView.clipsToBounds = true
        //loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect.init(x: loadingView.frame.size.width/2 - 20, y: loadingView.frame.size.height/2 - 20, width: 40.0, height: 40.0)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
        uiView.isUserInteractionEnabled = false
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(viewController: UIViewController) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
        viewController.view.isUserInteractionEnabled = true
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
}

//// In order to show the activity indicator, call the function from your view controller
//// ViewControllerUtils().showActivityIndicator(self.view)
//// In order to hide the activity indicator, call the function from your view controller
//// ViewControllerUtils().hideActivityIndicator(self.view)
