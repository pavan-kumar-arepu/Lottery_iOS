//
//  SoldTicketPresenter.swift
//  Lottery
//
//  Created by GuestUserLogin on 30/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
typealias TiketDetails = (bookletSeries: String, bookletNumber: String, ticketNumber: String, lotId: String)
enum SoldTicketFields {
    case bookletSeries, bookletNumber, ticketNumber, lotId
}

enum SoldTicketValidationResult {
    case success, failure(SoldTicketFields)
}

class SoldTicketPresenter {
    var view: SoldTicketViewController
    init(view: SoldTicketViewController) {
        self.view = view
    }
    var userId: String {
        return CommonUtils.userDetailsModel?._id ?? ""
    }
    
    var mobileNumber: String {
        return CommonUtils.userDetailsModel?.user_mobile_number ?? ""
    }
    
    func validateTicketData(details: TiketDetails)-> SoldTicketValidationResult {
        guard !details.bookletSeries.isEmpty  else {
            return .failure(.bookletSeries)
        }
        guard !details.bookletNumber.isEmpty else {
            return .failure(.bookletNumber)
        }
        guard !details.ticketNumber.isEmpty else {
            return .failure(.ticketNumber)
        }
        guard !details.lotId.isEmpty else {
            return .failure(.lotId)
        }
        return .success
    }
    
    func submitTicketDetailsApi(details: TiketDetails) {
        //http://155.138.208.35:82/lottory/sold_tickets_api?
        guard CommonUtils.isOnline() else {
            self.view.submitDetailsResult(result: .failure(apiHandlerErrors.noNetWork))
            return
        }
        //request params : booklet_series,booklet_number,ticket_number,lot_id,user_id
        ApiHandler.handleApi(with: .get, urlString: Constants.UrlManager.soldTicketApi(ticketDetails: details, userId: userId), headers: ["Content-Type": "application/json", "Accept": "application/json"], parameters: nil) { result in
            switch result {
            case .success(let data):
                self.view.submitDetailsResult(result: .success(""))
            case .failure(let error):
                self.view.submitDetailsResult(result: .failure(error))
            }
        }
    }
    
    
    
}
