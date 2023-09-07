//
//  ProfileInfo.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

struct ProfileInfo: Codable {
    let data: DataContainer
}

struct DataContainer: Codable {
    let profile: UserProfile
}

struct UserProfile: Codable {
    let login: String
    let firstName: String
    let lastName: String
    let email: String
    let groupName: String
    let points: [Point]

    enum CodingKeys: String, CodingKey {
        case login
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case groupName = "group_name"
        case points
    }
}

struct Point: Codable {
    let pointName: String
    enum CodingKeys: String, CodingKey {
        case pointName = "point_name"
    }
}
