//
//  LoginRequest.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

struct LoginRequest: NetworkRequest {

    let loginInfo: Login

    init(loginInfo: Login) {
        self.loginInfo = loginInfo
    }

    var endpoint: URL? {
        get {
            URL(string: self.baseEndpoint + "login")
        }
    }

    var httpMethod: HttpMethod {
        .post
    }

    var dto: Encodable? {
        loginInfo
    }
}
