//
//  LogoutNetworkService.swift
//  MilesTask
//
//  Created by D on 08.09.2023.
//
import Foundation

final class LogoutNetworkService {
    private let client = NetworkClient()

    func sendLogout(with data: Login, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        let requst = LogoutRequest(loginInfo: data)
        client.send(request: requst, type: ResponseModel.self, completion: completion)
    }
}

