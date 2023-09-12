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
    private let authStorage = AuthDataStorage.shared

    private var retryCount = 0

    @Observable
    private(set) var profile: UserProfile?

    @Observable
    private(set) var decisionAboutAuth: AuthSucccess = .none

    var loginModel: Login?

    private let group = DispatchGroup()

    init() {


        let loginSavedModel = authStorage.loadData()

        loginModel = loginSavedModel
        //checkForAuth()
        fetchProfile()
    }

    func fetchProfile() {
        profileService.getProfile { [weak self] result in
            guard let self else { return }
            self.group.enter()
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self.decideAfterAuth(profile.responseCode)
                    self.profile = profile.data?.profile
                case .failure(let error):
                    print(error.localizedDescription)
                    self.decisionAboutAuth = .failure
                }
                self.group.leave()
            }
        }
    }

    func logout() {
        guard let loginModel else { return }
        UserDefaults.standard.set(true, forKey: "isLogouted")
        authStorage.remove()
        logoutService.sendLogout(with: loginModel) { result in
            switch result {
            case .success(let code):
                print(code.responseCode)
            case .failure(let eror):
                print(eror)
            }
        }
    }

    private func decideAfterAuth(_ code: Int) {
        if code == 0 {
            decisionAboutAuth = .success
        } else if self.retryCount < 2 {
            retryCount += 1
            fetchProfile()
        } else {
            decisionAboutAuth = .failure
        }

        print(retryCount)
    }
}
