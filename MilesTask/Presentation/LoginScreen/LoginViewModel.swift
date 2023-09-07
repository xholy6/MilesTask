//
//  LoginViewModel.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import Foundation

enum AuthSucccess {
    case none
    case success
    case failure
}

final class LoginViewModel {
    private let authService = LoginNetworkService()

    @Observable
    private(set) var authSuccess: AuthSucccess = .none

    var loginModel: Login?

    private var login: String?
    private var password: String?

    var loginChanged: ((String?) -> Void)?
    var passwordChanged: ((String?) -> Void)?

    init() {
        subscribeForChanges()
    }

    func tryToAuth() {
        guard let login, let password else { return }
        print(login)
        print(password)
        loginModel = Login(login: login, password: password)
       guard let loginModel else { return }

        authService.sendAuth(with: loginModel) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.decideAfterAuth(response: data)
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }

    private func subscribeForChanges() {
        loginChanged = { [weak self] newText in
            self?.login = newText
        }

        passwordChanged = { [weak self] newText in
            self?.password = newText
        }
    }

    private func decideAfterAuth(response: ResponseModel) {
        switch response.responseCode {
        case 0:
            authSuccess = .success
        default:
            authSuccess = .failure
        }
    }
}
