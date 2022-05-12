// WeatherNoteCell.swift
// Created by Anastasiya Kudasheva

import UIKit

class WeatherNoteCell: UITableViewCell {
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
		label.font = AppFonts.bold24.font
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()
	private let weatherImageView = UIImageView()
	private let tempLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.bold24.font
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

private extension WeatherNoteCell {
	func setupLayot() {
		self.backgroundColor = .clear
		self.contentView.addSubview(self.townLabel)
		self.townLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
}
