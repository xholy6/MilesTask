//
//  infoCell.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import UIKit

final class InfoCell: UITableViewCell {

    static let reuseIdentifier = "infoCell"

    private lazy var titleLabel: CustomLabel = {
        CustomLabel(frame: .zero)
    }()

    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        activateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configCell(info: UserProfile, index: IndexPath) {
        setInfo(info, index)
    }

    func configDefault(title: String) {
        titleLabel.text = title
    }

    private func setInfo(_ info: UserProfile, _ index: IndexPath) {
        switch index.row {
        case 0:
            dataLabel.text = info.firstName
            print(info.firstName)
        case 1:
            dataLabel.text = info.lastName
        case 2:
            dataLabel.text = info.groupName
        case 3:
            dataLabel.text = info.email
            print(info.email)
        case 4:
            dataLabel.text = info.points.first?.pointName
        case 5:
            dataLabel.text = info.login
        default:
            break
        }
    }

    private func setupView() {
        contentView.backgroundColor = .mLightGray
        contentView.addSubview(titleLabel)
        contentView.addSubview(dataLabel)
    }

    private func activateConstraints() {
        let edge: CGFloat = 16
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: edge),

            dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -edge),
        ])
    }
}
