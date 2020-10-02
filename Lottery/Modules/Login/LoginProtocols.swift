//
//  LoginProtocols.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
protocol LoginViewToPresenterProtocol: class {
    func signInTapped(userName: String?, password: String?)-> LoginValidationResult
    func loginApi(using mobileNumbver: String, password: String)
}

protocol LoginPresenterToViewProtocol: class {
    func loginApiResult(result: Result<LoginEntityModel>)
}

protocol LoginPresenterToInteractor: class {
    func loginApi(using mobileNumbver: String, password: String)
}

protocol LoginInteractorToPresenter: class {
    func loginApiResult(result: Result<LoginEntityModel>)
}

enum LoginValidationFields {
    case mobileNumber, password
}

enum LoginValidationResult {
    case success, failure(LoginValidationFields)
}
