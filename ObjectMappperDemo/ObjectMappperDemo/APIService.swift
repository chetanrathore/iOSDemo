//
//  APIService.swift
//  StyleAgainApp
//
//  Created by Devloper30 on 20/10/16.
//  Copyright © 2016 Sonal. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    static let sharedInstance = APIService()
    let baseURL = ""

    func sendRequest(method: String, postedData: NSDictionary, apiMethod: String, completion: @escaping (Any, Bool, Bool) -> Void) {
        do {
            let url = NSURL(string: baseURL + apiMethod)
            var request = URLRequest(url: url! as URL)
            request.httpMethod = method
            request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ODdmMjk5ZDMyZjhhNDEwZjg0NjI5OGEiLCJpYXQiOjE0ODQ3Mjg3MzMsImV4cCI6MjI0MjExMTEzM30.nhPbnJOUeGU_wSwmawCMxNFtqOURlenagKMqdhPvQnk", forHTTPHeaderField: "x-access-token")

            if postedData.isEqual(to: [:]) {
            }else {
                let jsonData = try JSONSerialization.data(withJSONObject: postedData, options: .prettyPrinted)
                request.httpBody = jsonData
            }

            if postedData.isEqual(to: [:]) {
            }else {
                let jsonData = try JSONSerialization.data(withJSONObject: postedData, options: .prettyPrinted)
                request.httpBody = jsonData
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            Alamofire.request(request).responseJSON { response in
                if response.response?.statusCode == 200 {
                    let data = response.result.value
//                    data,isError,isConnectionError
                    completion(data ?? [:], false, false)
                }else if response.response?.statusCode == 401 {
                    let data = response.result.value
                    completion(data ?? [:], true, false)
                }else {
                    completion([:], false, true)
                }
            }
        } catch {
            print("Error : " + error.localizedDescription)
        }
    }

}
