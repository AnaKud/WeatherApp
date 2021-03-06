// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit
import SnapKit

class CurrentWeatherViewController: UIViewController {
	private enum Constants {
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

	private lazy var searchTextField: UITextField = {
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
		textField.delegate = self
		return textField
	}()

	private let weatherIconImageView = UIImageView()
	private let weatherWidget = WeatherWidgetView()

	private lazy var newNoteButton = WeatherButton(settings: .init(imageName: Constants.weatherButtonImage,
															  labelText: Texts.weatherButtonText,
															  font: .regular16,
															  tapHandler: { self.saveButtonTapped() }))

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let image = UIImageView(image: UIImage(named: "background"))
		image.contentMode = .scaleAspectFill
		self.view.addSubview(image)
		image.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		self.setupLayout()
		self.setAccessibilityIdentifier()
		
		self.displayWeatherData(CurrentWeatherViewModel())
	}

	func displayWeatherData(_ vm: CurrentWeatherViewModel) {
		self.weatherIconImageView.image = vm.weatherType.image
		self.weatherWidget.displayWeatherData(vm)
	}
}

// MARK: - Navigation
private extension CurrentWeatherViewController {
	func saveButtonTapped() {
		self.present(WeatherNoteAssembly.build(), animated: true)
	}
}

// MARK: - NetworkRequest
private extension CurrentWeatherViewController {
	func requestCurrentWeather(for city: String?) {
		print(city)
	}
}

private extension CurrentWeatherViewController {
	func setupLayout() {
		self.view.addSubview(self.searchTextField)
		self.searchTextField.snp.makeConstraints { make in
			make.top.equalTo(self.view.safeAreaLayoutGuide)
			make.leading.trailing.equalToSuperview().inset(Constants.horisontalSearchOffset)
			make.height.equalTo(Constants.searchHeight)
		}

		self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		self.view.addSubview(self.weatherIconImageView)
		self.weatherIconImageView.snp.makeConstraints { make in
			make.top.equalTo(self.searchTextField.snp.bottom).offset(Constants.topImageViewOffset)
			make.centerX.equalToSuperview()
			make.width.equalTo(self.weatherIconImageView.snp.height)
		}

		self.view.addSubview(self.weatherWidget)
		self.weatherWidget.snp.makeConstraints { make in
			make.top.equalTo(self.weatherIconImageView.snp.bottom).offset(Constants.topImageViewOffset)
			make.leading.trailing.equalToSuperview().inset(Constants.horisontalSearchOffset)
		}
		
		self.view.addSubview(self.newNoteButton)
		self.newNoteButton.snp.makeConstraints { make in
			make.top.equalTo(self.weatherWidget.snp.bottom).offset(Constants.buttonTopOffset)
			make.centerX.equalToSuperview()
			make.leading.lessThanOrEqualToSuperview().offset(Constants.buttonHorisontalOffset)
			make.trailing.lessThanOrEqualToSuperview().offset(-Constants.buttonHorisontalOffset).priority(.low)
			make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide)
		}
	}

	func setAccessibilityIdentifier() {
		self.weatherIconImageView.accessibilityIdentifier = "weatherIconImageView"
	}
}

extension CurrentWeatherViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.requestCurrentWeather(for: textField.text)
		return true
	}
}
