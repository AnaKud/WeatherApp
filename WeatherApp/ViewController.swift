// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit
import SnapKit

class CurentWeatherViewController: UIViewController {
	private enum Constants {
		static let topSearchOffset = 34
		static let horisontalSearchOffset = 30
		static let searchHeight = 58
		static let emptyViewWidth = 16

		static let topImageViewOffset = 36
		static let imageViewSize = 142

		static let cornerRadius: CGFloat = 16
		static let widgetViewOffset = 36
		
		static let buttonTopOffset = 35
		static let buttonHorisontalOffset = 97
		static let weatherButtonImage = "edit"
	}

	private enum Texts {
		static let searchTFPlaceholder = "Search here"
		static let weatherButtonText = "New weather note"
	}

	private let searchTextField: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .white
		textField.layer.cornerRadius = Constants.cornerRadius
		textField.layer.masksToBounds = true
		textField.attributedPlaceholder = NSAttributedString(
			string: Texts.searchTFPlaceholder,
			attributes: [
				NSAttributedString.Key.font: AppFonts.regular18.font as Any,
				NSAttributedString.Key.foregroundColor: Colors.lightBlue.value
			]
		)
		let emptyView = UIView(frame: .init(x: .zero, y: .zero, width: Constants.emptyViewWidth, height: .zero))
		textField.leftViewMode = .always
		textField.leftView = emptyView
		textField.rightViewMode = .always
		textField.rightView = emptyView
		return textField
	}()

	private let weatherIconImageView = UIImageView()
	private let weatherWidget = WeatherWidgetView()

	private let newNoteButton = WeatherButton(settings: .init(imageName: Constants.weatherButtonImage,
															  labelText: Texts.weatherButtonText,
															  font: .regular16,
															  tapHandler: {
		print("newNoteButtonTapped")
	}))

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(red: 0.29, green: 0.639, blue: 0.953, alpha: 1)
		self.setupLayout()
		self.setupWeatherData(WeatherViewModel())
	}

	func setupWeatherData(_ vm: WeatherViewModel) {
		self.weatherIconImageView.image = vm.weatherType.image
		self.weatherWidget.setupWeatherData(vm)
	}

	private func setupLayout() {
		self.view.addSubview(self.searchTextField)
		self.searchTextField.snp.makeConstraints { make in
			make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.topSearchOffset)
			make.leading.trailing.equalToSuperview().inset(Constants.horisontalSearchOffset)
			make.height.equalTo(Constants.searchHeight)
		}

		self.view.addSubview(self.weatherIconImageView)
		self.weatherIconImageView.snp.makeConstraints { make in
			make.top.equalTo(self.searchTextField.snp.bottom).offset(Constants.topImageViewOffset)
			make.centerX.equalToSuperview()
			make.height.width.equalTo(Constants.imageViewSize)
		}

		self.view.addSubview(self.weatherWidget)
		self.weatherWidget.snp.makeConstraints { make in
			make.top.equalTo(self.weatherIconImageView.snp.bottom).offset(Constants.topImageViewOffset)
			make.leading.trailing.equalToSuperview().inset(Constants.horisontalSearchOffset)
		}
		
		self.view.addSubview(self.newNoteButton)
		self.newNoteButton.snp.makeConstraints { make in
			make.top.equalTo(self.weatherWidget.snp.bottom).offset(Constants.buttonTopOffset)
			make.leading.equalToSuperview().offset(Constants.buttonHorisontalOffset)
			make.trailing.equalToSuperview().offset(-Constants.buttonHorisontalOffset)
			make.bottom.equalTo(self.view.safeAreaLayoutGuide)
		}
	}
}
