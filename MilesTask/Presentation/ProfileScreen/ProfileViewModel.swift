//
//  ProfileViewModel.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//
import Foundation

final class ProfileViewModel {

    private let profileService = ProfileNetworkService()
    private let logoutService = LogoutNetworkService()

    @Observable
    private(set) var profile: UserProfile?

    private let group = DispatchGroup()

    var loginModel: Login?

    init() {
        fetchProfile()
    }

    private func fetchProfile() {
        profileService.getProfile { [weak self] result in
            guard let self else { return }
            self.group.enter()
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self.profile = profile.data.profile
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.group.leave()
            }
        }
    }

    func logout() {
        guard let loginModel else { return }
        logoutService.sendLogout(with: loginModel) { _ in}
    }
}
