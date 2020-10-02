//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func startIndicator(indicator: UIActivityIndicatorView) {
        self.view.isUserInteractionEnabled = false
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            indicator.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        indicator.color = UIColor.black
        
        DispatchQueue.main.async {
            self.view.addSubview(indicator)
            indicator.startAnimating()
        }
    }
    
    func stopIndicator(indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
  
    func showOkayAlert(title: String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addShadowToView(view: UIView, shadowRadious: CGFloat = 1.0) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = shadowRadious
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func startLoadingIndicator(indicator: ActivityIndicatorService) {
        DispatchQueue.main.async {
            indicator.showActivityIndicator(viewController: self)
        }
    }
    
    func stopLoadingIndicator(indicator: ActivityIndicatorService) {
        DispatchQueue.main.async {
            indicator.hideActivityIndicator(viewController: self)
        }
    }
    
}
