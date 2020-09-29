//
//  LoginRouter.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import UIKit
class LoginRouter {
    static func createLoginModule()-> LoginViewController {
        guard let loginVC = CommonUtils.mainStoryboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else{
            preconditionFailure("Unable to get LoginViewController")
        }
        let presenter = LoginPresenter()
        let interactor = LoginInteractor()
        loginVC.presenter = presenter
        presenter.view = loginVC
        interactor.presenter = presenter
        presenter.interactor = interactor
        return loginVC
    }
    
}
