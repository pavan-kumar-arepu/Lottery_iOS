//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import UIKit

enum ApiResponse {
    case success(Data?)
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
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy:.useProtocolCachePolicy, timeoutInterval: 10.0)
        request.addValues(values: headers)
        request.httpMethod = httpMethode.rawValue
        if let parametrs = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parametrs)
            print (jsonData as Any)
            request.httpBody = jsonData
        }
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if let responseData = data, let dict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? NSDictionary {
                debugPrint("\(urlString) response", dict)
            }
            if let responseError = error {
                completionHandler(ApiResponse.failure(responseError))
            } else if let responseData = data {
                completionHandler(ApiResponse.success(responseData))
            } else {
                completionHandler(ApiResponse.failure(apiHandlerErrors.inValidRequest))
            }
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
