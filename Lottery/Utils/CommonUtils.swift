//
//  CommonUtils.swift
//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import UIKit

class CommonUtils {
    static let defults = UserDefaults.standard
    static func setNavigationStyles(colour: UIColor?, textTitleColour: UIColor) {
        UINavigationBar.appearance().barTintColor = colour
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:textTitleColour]
    }
    
    static var mainStoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static var ticketStoryboard: UIStoryboard{
        return UIStoryboard(name:"SoldTicket",bundle: Bundle.main)
    }
    
    static func isOnline()-> Bool {
        return Reachability()?.connection.description != "No Connection"
    }
    
    static func getDeviceWidthHeight()-> (width: CGFloat, height: CGFloat) {
        let screenRect = UIScreen.main.bounds
        return (screenRect.size.width, screenRect.size.height)
    }
    
    static func saveDefaults(key: String, value: Any) {
        defults.set(value, forKey: key)
    }
    
    static func getValueStringFromDefaults(key: String) -> String {
        return defults.string(forKey: key) ?? ""
    }
    
    static func getValueFromDefaults(key: String) -> Any? {
        return defults.value(forKey: key)
    }
    
   //MARK:- Get storage Values
    static var userName: String? {
        let userName = getValueStringFromDefaults(key: Constants.StorageKeys.userName)
        return userName.isEmpty ? nil: userName
    }
    
    static var password: String? {
        let password = getValueStringFromDefaults(key: userName ?? "")
        return password.isEmpty ? nil: password
    }
    
    static var user_Id: Int? {
        let key = "\(userName ?? "")_\(password ?? "")"
        return getValueFromDefaults(key: key) as? Int
    }
}
