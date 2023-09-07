//
//  ProfileRequest.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

struct ProfileRequest: NetworkRequest {

    var endpoint: URL? {
        get {
            URL(string: self.baseEndpoint + "profile")
        }
    }

    var httpMethod: HttpMethod {
        .get
    }
}
