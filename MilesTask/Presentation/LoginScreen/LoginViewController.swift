//
//  ViewController.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import UIKit

final class LoginViewController: UIViewController {

    private enum Constants  {
        static let titleLabel = "Войдите в профиль"
        static let loginPlaceholder = "Логин"
        static let passwordPlaceholder = "Пароль"
        static let doneButtonText = "Далее"
    }

    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        activateConstraints()
        bind()
        loginTextField.addTarget(self, action: #selector(loginFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.spacing = 50
        stack.axis = .vertical
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var textfieldsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 25
        return stack
    }()

    private lazy var loginTextField: CustomTextField = {
        CustomTextField(frame: .zero, placeholderText: Constants.loginPlaceholder)

    }()

    private lazy var passwordTextField: CustomTextField = {
        CustomTextField(frame: .zero, placeholderText: Constants.passwordPlaceholder)
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.doneButtonText, for: .normal)
        button.backgroundColor = .mRed
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()

    @objc
    private func doneButtonTapped() {
        viewModel.tryToAuth()
    }

    @objc
    private func loginFieldDidChange(_ textField: UITextField) {
        viewModel.loginChanged?(textField.text)
    }

    @objc
    private func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.passwordChanged?(textField.text)
    }

    private func showProfileScreen() {
        let vc = ProfileViewController()
        guard let loginData = try? JSONEncoder().encode(viewModel.loginModel) else {
            return
        }
        UserDefaults.standard.set(loginData, forKey: "LoginModel")
        UserDefaults.standard.set(false, forKey: "isLogouted")
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Неверный логин или пароль",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func bind() {
        viewModel.$authSuccess.bind { [weak self] code in
            switch code {
            case .success:
                self?.showProfileScreen()
                break
            case .failure:
                self?.showAlert()
            default:
                break
            }
        }
    }

    private func setupView() {
        textfieldsStack.addArrangedSubview(loginTextField)
        textfieldsStack.addArrangedSubview(passwordTextField)
        let views = [titleLabel, textfieldsStack, doneButton]

        view.addSubview(contentStack)
        views.forEach { contentStack.addArrangedSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    private func activateConstraints() {
        let edge: CGFloat = 16
        NSLayoutConstraint.activate([
       contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
        contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edge),
       contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edge),
        contentStack.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),

       doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

