//
//  LoginInteractor.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
class LoginInteractor: LoginPresenterToInteractor {
    var presenter: LoginPresenter?
    
    func loginApi(using mobileNumbver: String, password: String) {
        guard CommonUtils.isOnline() else {
             self.presenter?.outPuts?.loginApiResult(result: .failure(apiHandlerErrors.noNetWork))
            return
        }
        ApiHandler.handleApi(with: .get, urlString: Constants.UrlManager.loginApi(with: mobileNumbver, password: password), headers: ["Content-Type": "application/json", "Accept": "application/json"], parameters: nil) { result in
            switch result {
            case .success(let data, _):
                if let responseData = data, let resultModel = try? JSONDecoder().decode(LoginEntityModel.self, from: responseData), let userData = resultModel.data {
                    //Storing UserDetails
                    CommonUtils.saveDefaults(key: Constants.StorageKeys.userName, value: mobileNumbver)
                    CommonUtils.saveDefaults(key: mobileNumbver, value: password)
                    if let userId = userData._id {
                        CommonUtils.saveDefaults(key: "\(mobileNumbver)_\(password)", value: userId)
                    }
                    self.presenter?.outPuts?.loginApiResult(result: .success(resultModel))
                } else{
                    self.presenter?.outPuts?.loginApiResult(result: .failure(apiHandlerErrors.inValidRequest))
                }
            case .failure(let error):
                self.presenter?.outPuts?.loginApiResult(result: .failure(error))
            }
        }
    }
}
