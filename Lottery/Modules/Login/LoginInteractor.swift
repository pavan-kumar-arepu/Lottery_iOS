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
            case .success(_, let responseDict):
                    //Storing UserDetails
                    if let error = responseDict[LoginResponseKeys.error.rawValue] as? Bool, error == false {
                        CommonUtils.saveDefaults(key: Constants.StorageKeys.userName, value: mobileNumbver)
                        CommonUtils.saveDefaults(key: mobileNumbver, value: password)
                        if let userData = responseDict[LoginResponseKeys.data.rawValue] as? [String : Any], let userId = userData[LoginResponseKeys.DataKeys._id.rawValue] as? Int  {
                            CommonUtils.saveDefaults(key: "\(mobileNumbver)_\(password)", value: userId)
                        }
                    }
                    self.presenter?.outPuts?.loginApiResult(result: .success(responseDict))
            case .failure(let error):
                self.presenter?.outPuts?.loginApiResult(result: .failure(error))
            }
        }
    }
}
