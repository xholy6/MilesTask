//
//  ProfileViewController.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let cellHeight: CGFloat = 56
        static let cellCount = 6
    }

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

    private lazy var quitBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mLightGray
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var quitLabel: CustomLabel = {
        CustomLabel(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        activateConstraints()
    }

    private func setupView() {
        title = "Профиль"
        view.backgroundColor = .white
        view.addSubview(profileTableView)
        view.addSubview(quitBackView)
        quitBackView.addSubview(quitLabel)
    }

    private func activateConstraints() {
        let edge: CGFloat = 16
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edge),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edge),
            profileTableView.heightAnchor.constraint(equalToConstant: Constants.cellHeight * CGFloat(Constants.cellCount)),

            quitBackView.topAnchor.constraint(equalTo: profileTableView.bottomAnchor, constant: 50),
            quitBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edge),
            quitBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edge),
            quitBackView.heightAnchor.constraint(equalToConstant: 60),

            quitLabel.centerYAnchor.constraint(equalTo: quitBackView.centerYAnchor),
            quitLabel.leadingAnchor.constraint(equalTo: quitBackView.leadingAnchor, constant: 52),
        ])
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
