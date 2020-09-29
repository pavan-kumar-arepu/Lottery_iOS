//
//  LoginPresenter.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
class LoginPresenter: LoginViewToPresenterProtocol, LoginInteractorToPresenter {
    var inputs: LoginViewToPresenterProtocol {
        return self
    }
    var view: LoginPresenterToViewProtocol?
    var interactor: LoginPresenterToInteractor?
    
    func signInTapped(userName: String?, password: String?) {
        
    }
    
    func validateSignIn()-> Bool {
        return false
    }
}
