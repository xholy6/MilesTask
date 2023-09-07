//
//  CustomLabel.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import UIKit

final class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = .systemFont(ofSize: 16, weight: .semibold)
    }
}
