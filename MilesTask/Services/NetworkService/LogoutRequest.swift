//
//  LogoutRequest.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

struct LogoutRequest: NetworkRequest {

    let loginInfo: Login

    init(loginInfo: Login) {
        self.loginInfo = loginInfo
    }

    var endpoint: URL? {
        get {
            URL(string: self.baseEndpoint + "logout")
        }
    }

    var httpMethod: HttpMethod {
        .post
    }

    var dto: Encodable? {
        loginInfo
    }
}
