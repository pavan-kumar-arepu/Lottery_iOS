//
//  SoldTicketInteractor.swift
//  Lottery
//
//  Created by GuestUserLogin on 02/10/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
class SoldTicketInteractor {
    var presenter: SoldTicketPresenter?
    var userId: String {
        if let userId = CommonUtils.user_Id {
            return String(userId)
        }
        return ""
    }
    
    var mobileNumber: String {
        return CommonUtils.userName ?? ""
    }
    func submitTicketDetailsApi(details: TiketDetails) {
        guard CommonUtils.isOnline() else {
            self.presenter?.submitTicketResult(result: .failure(apiHandlerErrors.noNetWork))
            return
        }
        ApiHandler.handleApi(with: .get, urlString: Constants.UrlManager.soldTicketApi(ticketDetails: details, userId: userId), headers: ["Content-Type": "application/json", "Accept": "application/json"], parameters: nil) { result in
            switch result {
            case .success(_, let responseDict):
                self.presenter?.submitTicketResult(result: .success(responseDict))
            case .failure(let error):
                self.presenter?.submitTicketResult(result: .failure(error))
            }
        }
    }
}

class SoldTicketRouter {
    static func createLoginModule()-> SoldTicketViewController {
        guard let submitVC = CommonUtils.ticketStoryboard.instantiateViewController(identifier: "SoldTicketViewController") as? SoldTicketViewController else{
            preconditionFailure("Unable to get SoldTicketViewController")
        }
        let presenter = SoldTicketPresenter()
        let interactor = SoldTicketInteractor()
        submitVC.presenter = presenter
        presenter.view = submitVC
        interactor.presenter = presenter
        presenter.interactor = interactor
        return submitVC
    }
}
