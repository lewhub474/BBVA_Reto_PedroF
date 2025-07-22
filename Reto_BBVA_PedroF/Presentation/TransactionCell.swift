//
//  TransactionCell.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 21/07/25.
//

//import UIKit
//
//class TransactionCell: UITableViewCell {
//
//    // MARK: - UI Components
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 16)
//        label.textColor = UIColor.systemBlue
//        return label
//    }()
//
//    private let subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 14)
//        label.textColor = UIColor.lightGray
//        return label
//    }()
//
//    private let amountLabel: UILabel = {
//        let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 16)
//        label.textAlignment = .right
//        return label
//    }()
//
//    private let stackLeft = UIStackView()
//    private let stackMain = UIStackView()
//
//    // MARK: - Init
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configureUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        configureUI()
//    }
//
//    // MARK: - Public Configuration
//
//    func configure(with transaction: Transaction, showAmounts: Bool = true) {
//        nameLabel.text = transaction.name
//        subtitleLabel.text = "Movimiento BBVA" // puedes cambiar esto por una propiedad `description` si existe
//
//        let amount = transaction.amount
//        let isIngreso = transaction.type == "ingreso"
//
//        if showAmounts {
//            amountLabel.text = String(format: "$%.2f", abs(amount))
//        } else {
//            amountLabel.text = "••••"
//        }
//
//        amountLabel.textColor = isIngreso ? .systemGreen : .systemRed
//    }
//
//    // MARK: - UI Setup
//
//    private func configureUI() {
//        selectionStyle = .none
//        backgroundColor = .black
//
//        // stackLeft: name + subtitle
//        stackLeft.axis = .vertical
//        stackLeft.alignment = .leading
//        stackLeft.spacing = 2
//        stackLeft.translatesAutoresizingMaskIntoConstraints = false
//        stackLeft.addArrangedSubview(nameLabel)
//        stackLeft.addArrangedSubview(subtitleLabel)
//
//        // stackMain: stackLeft + amountLabel
//        stackMain.axis = .horizontal
//        stackMain.alignment = .center
//        stackMain.distribution = .fill
//        stackMain.spacing = 8
//        stackMain.translatesAutoresizingMaskIntoConstraints = false
//        stackMain.addArrangedSubview(stackLeft)
//        stackMain.addArrangedSubview(amountLabel)
//
//        contentView.addSubview(stackMain)
//
//        NSLayoutConstraint.activate([
//            stackMain.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
//            stackMain.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
//            stackMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            stackMain.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//        ])
//    }
//}

import UIKit

class TransactionCell: UITableViewCell {

    // MARK: - UI Components

    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .green
        return button
    }()

    private var transactionId: Int?
    private var onBookmarkTapped: ((Int) -> Void)?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = UIColor.systemBlue
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()

    private let stackLeft = UIStackView()
    private let stackRight = UIStackView()
    private let stackMain = UIStackView()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Public Configuration

    func configure(
        with transaction: Transaction,
        showAmounts: Bool = true,
        isBookmarked: Bool,
        onBookmarkTapped: @escaping (Int) -> Void
    ) {
        nameLabel.text = transaction.name
        subtitleLabel.text = "Movimiento BBVA"
        transactionId = transaction.id
        self.onBookmarkTapped = onBookmarkTapped

        let amount = transaction.amount
        let isIngreso = transaction.type == "ingreso"

        amountLabel.text = showAmounts ? String(format: "$%.2f", abs(amount)) : "••••"
        amountLabel.textColor = isIngreso ? .systemGreen : .systemRed

        let iconName = isBookmarked ? "bookmark.fill" : "bookmark"
        bookmarkButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    // MARK: - UI Setup

    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .black

        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)

        // stackLeft: name + subtitle
        stackLeft.axis = .vertical
        stackLeft.alignment = .leading
        stackLeft.spacing = 2
        stackLeft.translatesAutoresizingMaskIntoConstraints = false
        stackLeft.addArrangedSubview(nameLabel)
        stackLeft.addArrangedSubview(subtitleLabel)

        // stackRight: amount + bookmarkButton
        stackRight.axis = .horizontal
        stackRight.spacing = 8
        stackRight.alignment = .center
        stackRight.translatesAutoresizingMaskIntoConstraints = false
        stackRight.addArrangedSubview(amountLabel)
        stackRight.addArrangedSubview(bookmarkButton)

        // stackMain: stackLeft + stackRight
        stackMain.axis = .horizontal
        stackMain.alignment = .center
        stackMain.distribution = .equalSpacing
        stackMain.spacing = 12
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.addArrangedSubview(stackLeft)
        stackMain.addArrangedSubview(stackRight)

        contentView.addSubview(stackMain)

        NSLayoutConstraint.activate([
            stackMain.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackMain.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackMain.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    // MARK: - Actions

    @objc private func bookmarkTapped() {
        guard let id = transactionId else { return }
        onBookmarkTapped?(id)
    }
}
