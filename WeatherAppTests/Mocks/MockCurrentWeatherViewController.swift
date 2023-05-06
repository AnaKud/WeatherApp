// MockCurrentWeatherViewController.swift
// Created by Anastasiya Kudasheva

@testable import WeatherApp
import UIKit

class MockCurrentWeatherViewController: ICurrentWeatherViewController {
	private(set) var displayWeatherDataCalled = false
	private(set) var showLoadingIndicatorCalled = false
	private(set) var hideLoadingIndicatorCalled = false
	private(set) var presentAlertCalled = false

	private(set) var vm: CurrentWeatherViewModel!

	func displayWeatherData(_ vm: CurrentWeatherViewModel) {
		self.displayWeatherDataCalled = true
		self.vm = vm
	}

	func showLoadingIndicator() {
		self.showLoadingIndicatorCalled = true
	}

	func hideLoadingIndicator() {
		self.hideLoadingIndicatorCalled = true
	}

	func showSearchTextField() { }

	func present(_ viewControllerToPresent: UIViewController,
				 animated: Bool,
				 completion: (() -> Void)?) {
		self.presentAlertCalled = true
	}
}
