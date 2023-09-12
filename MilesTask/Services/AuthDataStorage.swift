//
//  AuthDataStorage.swift
//  MilesTask
//
//  Created by D on 12.09.2023.
//

import Foundation
import SwiftKeychainWrapper

final class AuthDataStorage {
    static let shared = AuthDataStorage()

    private let keyChain = KeychainWrapper.standard

    func setToStorage(_ data: Login) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            keyChain.set(encodedData, forKey: "Auth")

        }
    }

    func loadData() -> Login? {
        let decoder = JSONDecoder()
        guard let encodedData = try keyChain.data(forKey: "Auth") else { return nil }
        guard let authData = try? decoder.decode(Login.self, from: encodedData) else { return nil }
        return authData
    }

    func remove() {
        keyChain.remove(forKey: "Auth")
    }
}