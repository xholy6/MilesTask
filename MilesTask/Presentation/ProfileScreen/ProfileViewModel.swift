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

    private var retryCount = 0

    @Observable
    private(set) var profile: UserProfile?

    @Observable
    private(set) var decisionAboutAuth: AuthSucccess = .none

    var loginModel: Login?

    private let group = DispatchGroup()

    init() {
        guard let loginData = UserDefaults.standard.data(forKey: "LoginModel"),
              let loginSavedModel = try? JSONDecoder().decode(Login.self, from: loginData) else {
            self.loginModel = nil
            return
        }

        loginModel = loginSavedModel
        checkForAuth()
    }

    func fetchProfile() {
        profileService.getProfile { [weak self] result in
            guard let self else { return }
            self.group.enter()
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self.profile = profile.data.profile
                    self.decisionAboutAuth = .success
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.group.leave()
            }
        }
    }

    func checkForAuth() {
        profileService.checkAuth { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let code):
                    self.decideAfterAuth(code)
                case .failure(_):
                    break
                }
            }
        }
    }

    func logout() {
        guard let loginModel else { return }
        UserDefaults.standard.set(true, forKey: "isLogouted")
        logoutService.sendLogout(with: loginModel) { _ in}
    }

    private func decideAfterAuth(_ code: ResponseModel) {
        if code.responseCode == 0 {
            fetchProfile()
        } else if self.retryCount < 2 {
            retryCount += 1
            checkForAuth()
        } else {
            decisionAboutAuth = .failure
        }
    }
}
