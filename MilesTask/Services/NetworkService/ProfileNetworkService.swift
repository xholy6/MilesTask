//
//  ProfileNetworkService.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

final class ProfileNetworkService {
    private let client = NetworkClient()
    private let request = ProfileRequest()

    func getProfile(completion: @escaping (Result<ProfileInfo, Error>) -> Void) {
        client.send(request: request, type: ProfileInfo.self, completion: completion)
    }

    func checkAuth(completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        client.send(request: request, type: ResponseModel.self, completion: completion)
    }
}
