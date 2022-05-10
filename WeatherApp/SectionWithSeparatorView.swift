// SectionWithSeparatorView.swift
// Created by Anastasiya Kudasheva

import UIKit

class SectionWithSeparatorView: UIView {
	enum Atmosphere {
		case wind
		case humidity
		
		var desctiption: String {
			switch self {
			case .wind: return "Ветер"//"Wind"
			case .humidity: return "Влажность123456789" // "Hum"
			}
		}

		var image: UIImage? {
			switch self {
			case .wind: return UIImage(named: "windy")
			case .humidity: return UIImage(named: "hum")
			}
		}
	}

	private enum Constraints {
		static let imageViewVericalOffSet = 5
	}

	private let imageView = UIImageView()
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.3
		label.lineBreakMode = .byClipping
		label.sizeToFit()
		label.textAlignment = .center
		label.textColor = .white
		label.font = AppFonts.regular20.font
		return label
	}()
	private let separatorLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textAlignment = .center
		label.text = "|"
		label.textColor = .white
		label.font = AppFonts.regular20.font
		return label
	}()
	private let dataLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .left
		label.textColor = .white
		label.font = AppFonts.regular20.font
		return label
	}()
	
	init(type: Atmosphere) {
		super.init(frame: .zero)
		self.configureView(with: type)
		self.setupLayout()
		self.backgroundColor = .clear
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupData(_ value: String) {
		self.dataLabel.text = value
	}
}

private extension SectionWithSeparatorView {
	func configureView(with type: Atmosphere) {
		self.imageView.image = type.image
		self.nameLabel.text = type.desctiption
	}

	func setupLayout() {
		self.addSubview(self.imageView)
		self.imageView.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(Constraints.imageViewVericalOffSet)
			make.leading.equalToSuperview()
		}
		self.addSubview(self.separatorLabel)
		self.separatorLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		self.nameLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
		self.addSubview(self.nameLabel)
		self.nameLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(Constraints.imageViewVericalOffSet)
			make.leading.equalTo(self.imageView.snp.trailing)
			make.trailing.equalTo(self.separatorLabel.snp.leading)
		}
		self.addSubview(self.dataLabel)
		self.dataLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(Constraints.imageViewVericalOffSet)
			make.leading.equalTo(self.separatorLabel.snp.trailing)
			make.trailing.equalToSuperview()
		}
	}
}
