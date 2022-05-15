// WeatherNoteCell.swift
// Created by Anastasiya Kudasheva

import UIKit

class WeatherNoteCell: UITableViewCell {
	private enum Constraint {
		static let topBottomInset = 18
		static let horizontalInset = 25
	}
	
	static let id = String(describing: WeatherNoteCell.self)
	
	private let townLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.bold24.font
		label.textAlignment = .left
		label.textColor = .white
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
		self.displayData()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func displayData() {
		self.townLabel.text = "St.Petersbwr"
		self.dateLabel.text = "27 Apt"
		self.weatherImageView.image = UIImage(named: "sunny")
		self.tempLabel.text = "270"
	}
}

private extension WeatherNoteCell {
	func setupLayot() {
		self.selectionStyle = .none
		self.backgroundColor = .clear
		self.contentView.addSubview(self.townLabel)
		self.townLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.leading.equalToSuperview().offset(16)
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
			make.width.height.equalTo(48)
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.centerY.equalToSuperview().priority(.high)
		}
		self.contentView.addSubview(self.tempLabel)
		self.tempLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.weatherImageView.snp.trailing).offset(Constraint.horizontalInset)
			make.top.bottom.equalToSuperview().inset(Constraint.topBottomInset)
			make.centerY.equalToSuperview().priority(.high)
			make.trailing.equalToSuperview().offset(-16)
		}
	}
}
