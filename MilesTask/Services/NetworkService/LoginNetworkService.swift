//
//  LoginNetworkService.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

final class LoginNetworkService {
    private let client = NetworkClient()

    func sendAuth(with data: Login, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        let requst = LoginRequest(loginInfo: data)
        client.send(request: requst, type: ResponseModel.self, completion: completion)
    }
}

