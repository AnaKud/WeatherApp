// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit
import SnapKit

protocol ICurrentWeatherViewController: IAlertPresentable {
	func displayWeatherData(_ vm: CurrentWeatherViewModel)

	func showLoadingIndicator()
	func hideLoadingIndicator()

	func showSearchTextField()
}

class CurrentWeatherViewController: UIViewController {
	private enum Constants {
		static let horizontalOffset = 32
		static let searchHeight = 56

		static let topOffset = 16
		static let imageViewSize = 144

		static let cornerRadius: CGFloat = 16
		
		static let cityNameTopOffset = 48
	}

	private enum Texts {
		static let currentCityPlaceholder = "Current location:"
	}

	override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

	private lazy var activityIndicatorView: UIActivityIndicatorView = {
		let activityIndicatorView = UIActivityIndicatorView()
		activityIndicatorView.hidesWhenStopped = true
		activityIndicatorView.style = .large
		activityIndicatorView.color = Colors.white.value
		return activityIndicatorView
	}()

	private lazy var searchTextField: UITextField = {
		let textField = SearchTextField()
		textField.delegate = self
		textField.accessibilityIdentifier = "searchTextField"
		return textField
	}()

	private lazy var currentCityLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.bold24.font
		label.textAlignment = .center
		label.text = Texts.currentCityPlaceholder
		label.numberOfLines = 0
		label.textColor = .white
		label.accessibilityIdentifier = "currentCityLabel"
		return label
	}()

	private lazy var cityLabel: UILabel = {
		let label = UILabel()
		label.font = AppFonts.regular20.font
		label.textAlignment = .center
		label.numberOfLines = 0
		label.textColor = .white
		label.accessibilityIdentifier = "cityLabel"
		return label
	}()

	private lazy var weatherIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.accessibilityIdentifier = "weatherIconImageView"
		return imageView
	}()

	private let weatherWidget = WeatherWidgetView()

	private let presenter: ICurrentWeatherPresenter

	init(presenter: ICurrentWeatherPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureBackground()
		self.setupLayout()

		self.presenter.didLoad(self)
	}
}

extension CurrentWeatherViewController: ICurrentWeatherViewController {
	func displayWeatherData(_ vm: CurrentWeatherViewModel) {
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			self.weatherIconImageView.image = vm.weatherType.image
			self.weatherWidget.displayWeatherData(vm)
			self.cityLabel.text = vm.city
		}
	}

	func showLoadingIndicator() {
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			self.activityIndicatorView.isHidden = false
			self.activityIndicatorView.startAnimating()

			self.searchTextField.isHidden = true
			self.weatherIconImageView.isHidden = true
			self.currentCityLabel.isHidden = true
			self.cityLabel.isHidden = true
			self.weatherIconImageView.isHidden = true
			self.weatherWidget.isHidden = true
		}
	}

	func hideLoadingIndicator() {
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			self.activityIndicatorView.stopAnimating()

			self.searchTextField.isHidden = false
			self.weatherIconImageView.isHidden = false
			self.currentCityLabel.isHidden = false
			self.cityLabel.isHidden = false
			self.weatherIconImageView.isHidden = false
			self.weatherWidget.isHidden = false
		}
	}

	func showSearchTextField() {
		DispatchQueue.main.async { [weak self] in
			guard let self else { return }
			self.activityIndicatorView.stopAnimating()
			self.searchTextField.isHidden = false
		}
	}
}

private extension CurrentWeatherViewController {
	func requestCurrentWeather(for city: String?) {
		guard let city else { return }
		self.presenter.searchFieldTextEntered(city)
	}
}

private extension CurrentWeatherViewController {
	func configureBackground() {
		let image = UIImageView(image: UIImage(named: "Background"))
		image.contentMode = .scaleAspectFill
		self.view.addSubview(image)
		image.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	func setupLayout() {
		self.view.addSubview(self.activityIndicatorView)
		self.activityIndicatorView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}

		self.view.addSubview(self.searchTextField)
		self.searchTextField.snp.makeConstraints { make in
			make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.topOffset)
			make.leading.trailing.equalToSuperview().inset(Constants.horizontalOffset)
			make.height.equalTo(Constants.searchHeight)
		}

		self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		self.weatherIconImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		self.view.addSubview(self.weatherIconImageView)
		self.weatherIconImageView.snp.makeConstraints { make in
			make.top.equalTo(self.searchTextField.snp.bottom).offset(Constants.topOffset)
			make.centerX.equalToSuperview()
			make.width.equalTo(self.weatherIconImageView.snp.height)
		}

		self.view.addSubview(self.weatherWidget)
		self.weatherWidget.snp.makeConstraints { make in
			make.top.equalTo(self.weatherIconImageView.snp.bottom).offset(Constants.topOffset)
			make.leading.trailing.equalToSuperview().inset(Constants.horizontalOffset)
		}

		self.view.addSubview(self.currentCityLabel)
		self.currentCityLabel.snp.makeConstraints { make in
			make.top.equalTo(self.weatherWidget.snp.bottom).offset(Constants.cityNameTopOffset)
			make.centerX.equalToSuperview()
			make.leading.lessThanOrEqualToSuperview().offset(Constants.horizontalOffset)
			make.trailing.lessThanOrEqualToSuperview().offset(-Constants.horizontalOffset).priority(.low)
		}

		self.view.addSubview(self.cityLabel)
		self.cityLabel.snp.makeConstraints { make in
			make.top.equalTo(self.currentCityLabel.snp.bottom)
			make.centerX.equalToSuperview()
			make.leading.lessThanOrEqualToSuperview().offset(Constants.horizontalOffset)
			make.trailing.lessThanOrEqualToSuperview().offset(-Constants.horizontalOffset).priority(.low)
			make.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide)
		}
	}
}

extension CurrentWeatherViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.requestCurrentWeather(for: textField.text)
		self.view.endEditing(true)
		return true
	}
}
