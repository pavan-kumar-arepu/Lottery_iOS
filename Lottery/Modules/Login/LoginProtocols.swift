//
//  LoginProtocols.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
protocol LoginViewToPresenterProtocol: class {
    func signInTapped(userName: String?, password: String?)
}

protocol LoginPresenterToViewProtocol: class {
    
}

protocol LoginPresenterToInteractor: class {
    
}

protocol LoginInteractorToPresenter: class {
    
}
