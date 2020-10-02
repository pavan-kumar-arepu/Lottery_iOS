//
//  AppSingleton.swift
//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import UIKit

class AppSingleton {
    static var shared = AppSingleton()
    var user: UserDetails?
}

class UserDetails {
    var userId: String
    var userName: String
    var email: String
    var phoneNumber: String
    var password: String
    init(userId: String, userName: String, email: String, phoneNumber: String, password: String) {
        self.userId = userId
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.password = password
        self.email = email
    }
}
