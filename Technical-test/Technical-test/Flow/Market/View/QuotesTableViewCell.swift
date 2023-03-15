//
//  QuotesTableViewCell.swift
//  Technical-test
//
//  Created by Alexander Balagurov on 15.03.2023.
//

import UIKit

private extension UIImage {

    static let favorite = UIImage(named: "favorite")!
    static let noFavorite = UIImage(named: "no-favorite")!
}

final class QuotesTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let lastCurrencyLabel = UILabel()
    private let changePercentLabel = UILabel()
    private let favoriteImageView = UIImageView()

    var viewConfiguration: ViewConfiguration? {
        didSet {
            viewConfigurationDidChange()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        lastCurrencyLabel.text = ""
        changePercentLabel.text = ""
        favoriteImageView.image = nil
    }
}

extension QuotesTableViewCell {

    struct ViewConfiguration {
        let name: String
        let lastValue: String
        let currency: String
        let changePercent: String
        let isFavorite: Bool
        let variationColor: String
    }
}

private extension QuotesTableViewCell {

    func setup() {
        selectionStyle = .none
        setupStackView()
    }

    func setupStackView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = UIDimension.layoutMargin
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIDimension.layoutMargin2x),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIDimension.layoutMargin2x),
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIDimension.layoutMargin2x),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIDimension.layoutMargin2x)
            ]
        )
        configureArrangedSubviews(for: stackView)
    }

    func configureArrangedSubviews(for stackView: UIStackView) {
        let nameStackView = UIStackView()
        nameStackView.axis = .vertical
        nameStackView.spacing = UIDimension.layoutMargin

        [nameLabel, lastCurrencyLabel].forEach {
            nameStackView.addArrangedSubview($0)
        }

        [nameStackView, changePercentLabel, favoriteImageView].forEach {
            stackView.addArrangedSubview($0)
        }
        changePercentLabel.setContentHuggingPriority(.required, for: .horizontal)
        favoriteImageView.setContentHuggingPriority(.required, for: .horizontal)
    }

    func viewConfigurationDidChange() {
        guard let viewConfiguration else { return }

        nameLabel.text = viewConfiguration.name
        lastCurrencyLabel.text = viewConfiguration.lastValue + viewConfiguration.currency
        changePercentLabel.text = viewConfiguration.changePercent
        changePercentLabel.textColor = VariationColor(rawValue: viewConfiguration.variationColor)?.asUIColor
        favoriteImageView.image = viewConfiguration.isFavorite ? .favorite : .noFavorite
    }
}
