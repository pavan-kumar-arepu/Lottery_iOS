//
//  LoginEntity.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation

struct LoginEntityModel: Codable {
    var error: Bool?
    var data: UserDataModel?
    var error_msg: String?
}
struct UserDataModel: Codable {
    var created_at: String?
    var created_by: Int?
    var email: String?
    var country_id: Int?
    var entity_id: Int?
    var remember_token: String?
    var user_last_name: String?
    var user_mobile_number: String?
    var user_first_name: String?
    var user_role_id: Int?
    var user_active_inactive: String?
    var state_id: Int?
    var _id: Int?
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case created_at, created_by, email, country_id, remember_token, user_last_name, user_mobile_number, user_role_id, user_active_inactive, state_id, entity_id
    }
}
