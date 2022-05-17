// WeatherDiaryNoteCell.swift
// Created by Anastasiya Kudasheva

import UIKit

class WeatherDiaryNoteCell: UITableViewCell {
	private enum Constraint {
		static let topBottomInset = 18
		static let horizontalInset = 25
		static let horizontalSuperviewOffset = 16
		static let weatherImageViewSize = 48
		static let tempLabelWidth = 40
	}
	
	static let id = String(describing: WeatherDiaryNoteCell.self)
	
	private let townLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.bold24.font
		label.textAlignment = .left
		label.textColor = .white
		label.adjustsFontSizeToFitWidth = true
		return label
	}()
	private let dateLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.regular20.font
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	private let weatherImageView = UIImageView()
	private let tempLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.regular20.font
		label.textAlignment = .right
		label.textColor = .white
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setupLayot()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension WeatherDiaryNoteCell {
	func displayData(_ vm: WeatherDiaryViewModel) {
		self.townLabel.text = vm.town
		self.dateLabel.text = vm.date
		self.weatherImageView.image = vm.weatherImage.image
		self.tempLabel.text = vm.temperature
	}
}

private extension WeatherDiaryNoteCell {
	func setupLayot() {
		self.selectionStyle = .none
		self.backgroundColor = .clear
		self.contentView.addSubview(self.townLabel)
		self.townLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.leading.equalToSuperview().offset(Constraint.horizontalSuperviewOffset)
			make.centerY.equalToSuperview().priority(.high)
		}
		self.contentView.addSubview(self.dateLabel)
		self.dateLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.leading.equalTo(self.townLabel.snp.trailing).offset(Constraint.horizontalInset)
			make.centerY.equalToSuperview().priority(.high)
		}
		self.contentView.addSubview(self.weatherImageView)
		self.weatherImageView.snp.makeConstraints { make in
			make.leading.equalTo(self.dateLabel.snp.trailing).offset(Constraint.horizontalInset)
			make.width.height.equalTo(Constraint.weatherImageViewSize)
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.centerY.equalToSuperview().priority(.high)
		}
		self.tempLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		self.contentView.addSubview(self.tempLabel)
		self.tempLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.weatherImageView.snp.trailing).offset(Constraint.horizontalInset)
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.centerY.equalToSuperview().priority(.high)
			make.trailing.equalToSuperview().offset(-Constraint.horizontalSuperviewOffset)
			make.width.equalTo(Constraint.tempLabelWidth)
		}
	}
}
