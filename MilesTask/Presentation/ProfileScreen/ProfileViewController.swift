//
//  ProfileViewController.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import UIKit

enum ProfileProperties: String, CaseIterable {
    case login = "Логин"
    case pointService = "Точка обслуживания"
    case mail = "Почта"
    case group = "Должность"
    case lastname = "Фамилия"
    case name = "Имя"
}


final class ProfileViewController: UIViewController {

    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let cellHeight: CGFloat = 56
        static let cellCount = 6
        static let qrcodeButtonSize: CGFloat = 72
    }

    var viewModel = ProfileViewModel()

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.layer.masksToBounds = true
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.reuseIdentifier)
        return tableView
    }()

    private lazy var quitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выйти из профиля", for: .normal)
        button.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        button.backgroundColor = .mLightGray
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .leading
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return button
    }()

    private lazy var qrcodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "qrcode"), for: .normal)
        button.backgroundColor = .mRed
        let padding: CGFloat = 16
        button.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
        activateConstraints()
    }

    private func bind() {
        viewModel.$decisionAboutAuth.bind { [weak self] authSuccess in
            switch authSuccess {
            case .failure:
                self?.showLoginVC()
            case .success:
                self?.profileTableView.reloadData()
            default:
                break
            }
        }

    }

    @objc
    private func quitButtonTapped() {
        showLoginVC()
    }

    private func showLoginVC() {
        viewModel.logout()
        navigationController?.setViewControllers([LoginViewController()], animated: true)
    }
    
    private func setupView() {
        title = "Профиль"
        view.backgroundColor = .white
        view.addSubview(profileTableView)
        view.addSubview(quitButton)
        view.addSubview(qrcodeButton)
    }

    private func activateConstraints() {
        let edge: CGFloat = 16
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edge),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edge),
            profileTableView.heightAnchor.constraint(equalToConstant: Constants.cellHeight * CGFloat(Constants.cellCount)),

            quitButton.topAnchor.constraint(equalTo: profileTableView.bottomAnchor, constant: 50),
            quitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edge),
            quitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edge),
            quitButton.heightAnchor.constraint(equalToConstant: 48),

            qrcodeButton.topAnchor.constraint(equalTo: quitButton.bottomAnchor, constant: 32),
            qrcodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrcodeButton.heightAnchor.constraint(equalToConstant: Constants.qrcodeButtonSize),
            qrcodeButton.widthAnchor.constraint(equalToConstant: Constants.qrcodeButtonSize),
        ])

        qrcodeButton.layer.cornerRadius = Constants.qrcodeButtonSize/2
        qrcodeButton.layer.masksToBounds = true
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        Constants.cellCount
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: InfoCell.reuseIdentifier, for: indexPath) as? InfoCell
        else { return InfoCell() }

        let allCases = ProfileProperties.allCases

        if let profile = viewModel.profile {
            cell.configCell(info: profile, index: indexPath)
        } else {
            cell.configDefault(title: allCases[indexPath.row].rawValue)
        }
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        Constants.cellHeight
    }
}
