import UIKit

final class CustomTextField: UITextField {

    private let inset: CGFloat = 16

    init(frame: CGRect, placeholderText: String) {
        super.init(frame: frame)
        setupView(placeholderText: placeholderText)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: inset, dy: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: inset, dy: inset)
    }
    private func setupView(placeholderText: String) {
        font = UIFont.systemFont(ofSize: 17)
        backgroundColor = .mLightGray
        textAlignment = .left
        attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        layer.cornerRadius = 16
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
