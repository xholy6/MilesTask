//
//  LoginModel.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

struct Login: Codable {
    let login: String
    let password: String
    let deviceInfo: DeviceInfo = DeviceInfo()

    enum CodingKeys: String, CodingKey {
        case login
        case password
        case deviceInfo = "device_info"
    }
}

struct DeviceInfo: Codable {
    let os: String = "iOS"
    let ipAddress: String = "192.168.1.183"

    enum CodingKeys: String, CodingKey {
        case os
        case ipAddress = "ip_address"
    }
}
