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
    var view: SoldTicketViewController?
    var interactor: SoldTicketInteractor?
    
    
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
        self.interactor?.submitTicketDetailsApi(details: details)
    }
    
    func submitTicketResult(result: Result<[String: Any]>) {
        self.view?.submitDetailsResult(result: result)
    }
    
}
