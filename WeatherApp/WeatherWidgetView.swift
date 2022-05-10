// WeatherWidgetView.swift
// Created by Anastasiya Kudasheva

import UIKit

class WeatherWidgetView: UIView {
	private enum Constraints {
		static let dateLabelTopOffset = 17
		static let separatorSectionTopOffset = 37
		static let separatorSectionHorisontalOffset = 77
		static let humBootomOffset = -25
	}
	private enum Constants {
		static let corner: CGFloat = 16
	}

	private let dateLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.textColor = .white
		label.font = AppFonts.regular18.font
		return label
	}()
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.textColor = .white
		label.font = AppFonts.regular100.font
		return label
	}()
	private let weatherDescribeLabel : UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.textColor = .white
		label.font = AppFonts.bold24.font
		return label
	}()

	private let windView = SectionWithSeparatorView(type: .wind)
	private let humidityView = SectionWithSeparatorView(type: .humidity)

	init() {
		super.init(frame: .zero)
		self.configureView()
		self.setupLayout()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupWeatherData(_ vm: WeatherViewModel) {
		self.dateLabel.text = vm.date
		self.temperatureLabel.text = vm.temp
		self.weatherDescribeLabel.text = vm.weatherType.description
		self.windView.setupData(vm.wind)
		self.humidityView.setupData(vm.humidity)
	}
}

private extension WeatherWidgetView {
	func configureView() {
		self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
		self.layer.cornerRadius = Constants.corner
		self.layer.borderWidth = 2
		self.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
		self.layer.masksToBounds = true
	}

	func setupLayout() {
		self.addSubview(self.dateLabel)
		self.dateLabel.snp.makeConstraints { make in
			make.top.equalTo(self).offset(Constraints.dateLabelTopOffset)
			make.trailing.leading.equalToSuperview()
		}
		self.addSubview(self.temperatureLabel)
		self.temperatureLabel.snp.makeConstraints { make in
			make.top.equalTo(self.dateLabel.snp.bottom)
			make.trailing.leading.equalToSuperview()
		}
		self.addSubview(self.weatherDescribeLabel)
		self.weatherDescribeLabel.snp.makeConstraints { make in
			make.top.equalTo(self.temperatureLabel.snp.bottom)
			make.trailing.leading.equalToSuperview()
		}
		self.windView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
		self.addSubview(self.windView)
		self.windView.snp.makeConstraints { make in
			make.width.lessThanOrEqualToSuperview().priority(.high)
			make.top.equalTo(self.weatherDescribeLabel.snp.bottom).offset(Constraints.separatorSectionTopOffset)
			make.centerX.equalToSuperview().priority(.high)
			make.trailing.equalToSuperview().priority(.low)
			make.leading.equalToSuperview().priority(.low)
		}
		self.humidityView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
		self.addSubview(self.humidityView)
		self.humidityView.snp.makeConstraints { make in
			make.width.lessThanOrEqualToSuperview().priority(.high)
			make.top.equalTo(self.windView.snp.bottom)
			make.centerX.equalToSuperview().priority(.high)
			make.trailing.equalToSuperview()//.priority(.low)
			make.leading.equalToSuperview()//.priority(.low)
			make.bottom.equalTo(self).offset(Constraints.humBootomOffset)
		}
	}
}
