//
//  Constants.swift
//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
struct Constants {
    struct AlertMessages {
        static let noInternetMessage = "Your not connected to internet. Please connect to internet and try again."
        static let walletFailureMessage = "Unable to get wallet information."
        static let inValidaRequests = "Invalid Requeast try againe."
    }
    
    struct StorageKeys {
        static let userName = "UserName"
    }
    
    struct UrlManager {
        static let loginApi = "http://155.138.208.35:82/lottory/login_api?"
        static let submitDetailsApi = "http://155.138.208.35:82/lottory/sold_tickets_api?"
        static let dashBoardApi = "http://155.138.208.35:82/lottory/user_authenticte_api?"
        
        static func loginApi(with number: String, password: String)-> String {
            return "\(loginApi)number=\(number)&password=\(password)"
        }
        
        static func soldTicketApi(ticketDetails: TiketDetails, userId: String)-> String {
            return "\(submitDetailsApi)lot_id=\(ticketDetails.lotId)&booklet_series=\(ticketDetails.bookletSeries)&booklet_number=\(ticketDetails.bookletNumber)&user_id=\(userId)&ticket_number=\(ticketDetails.ticketNumber)"
        }
        
        static func dashBoardApi(with number: String, password: String)-> String {
            return "\(dashBoardApi)\(number)&password=\(password)"
        }
        
    }
    
    
}
