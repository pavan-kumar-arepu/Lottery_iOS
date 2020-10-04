//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import UIKit

enum ApiResponse {
    case success(Data?, [String: Any])
    case failure(Error)
}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

protocol responseError: Error {
    var description: String { get }
}

enum apiHandlerErrors: responseError {
    case noNetWork, inValidRequest
    var description: String {
        switch self {
        case .noNetWork:
            return Constants.AlertMessages.noInternetMessage
        case .inValidRequest:
            return Constants.AlertMessages.inValidaRequests
        }
    }
}

enum apiMethode: String {
    case post = "POST"
    case get = "GET"
}

class ApiHandler {
    //static let shared = ApiHandler()
    static func handleApi(with httpMethode: apiMethode, urlString: String, headers: [String: String], parameters: [String: Any]?, _ completionHandler : @escaping (_ result: ApiResponse) -> Void) {
        guard CommonUtils.isOnline() else {
            completionHandler(ApiResponse.failure(apiHandlerErrors.noNetWork))
            return
        }
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy:.useProtocolCachePolicy, timeoutInterval: 30.0)
        request.addValues(values: headers)
        request.httpMethod = httpMethode.rawValue
        if let parametrs = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parametrs)
            print (jsonData as Any)
            request.httpBody = jsonData
        }
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if let responseError = error {
                completionHandler(ApiResponse.failure(responseError))
                return
            }
            guard let responseData = data, let json = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] else {
                completionHandler(ApiResponse.failure(apiHandlerErrors.inValidRequest))
                return
            }
            debugPrint("\(urlString) response", json)
            completionHandler(ApiResponse.success(responseData, json))
        }
        task.resume()
    }
}

extension NSMutableURLRequest {
    func addValues(values: [String:String]) {
        values.forEach { (key, value) in
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
}
