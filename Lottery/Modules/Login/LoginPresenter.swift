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
    var outPuts: LoginInteractorToPresenter? {
        return self
    }
    var view: LoginPresenterToViewProtocol?
    var interactor: LoginPresenterToInteractor?
    
    func signInTapped(userName: String?, password: String?)-> LoginValidationResult {
        guard let mobileNumber = userName, mobileNumber.count == 10  else {
            return .failure(.mobileNumber)
        }
        guard let passwordString = password, !passwordString.isEmpty else {
            return .failure(.password)
        }
        return .success
    }
    
    func loginApi(using mobileNumbver: String, password: String) {
        self.interactor?.loginApi(using: mobileNumbver, password: password)
    }
    
    func loginApiResult(result: Result<[String: Any]>) {
        self.view?.loginApiResult(result: result)
    }
    
}
