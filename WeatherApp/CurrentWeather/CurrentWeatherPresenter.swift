// CurrentWeatherPresenter.swift
// Created by Anastasiya Kudasheva

import CoreLocation

protocol ICurrentWeatherPresenter: AnyObject {
	func didLoad(_ vc: ICurrentWeatherViewController)
	func searchFieldTextEntered(_ text: String)
}

class CurrentWeatherPresenter {
	private let locationManager: ILocationManager
	private let networkLoader: NetworkDataLoading
	private let alertPresenter: IAlertPresenter
	private weak var vc: ICurrentWeatherViewController?

	init(locationManager: ILocationManager,
		 networkLoader: NetworkDataLoading,
		 alertPresenter: IAlertPresenter) {
		self.locationManager = locationManager
		self.networkLoader = networkLoader
		self.alertPresenter = alertPresenter
	}
}

extension CurrentWeatherPresenter: ICurrentWeatherPresenter {
	func didLoad(_ vc: ICurrentWeatherViewController) {
		self.vc = vc
		self.alertPresenter.didLoad(vc)
		self.vc?.showLoadingIndicator()

		self.configureLocationManagerDelegateHandler()

		self.getCurrentLocation()
	}

	func searchFieldTextEntered(_ text: String) {
		self.locationManager.getLocation(for: text, completion: self.makeCompletion())
	}
}

private extension CurrentWeatherPresenter {
	func configureLocationManagerDelegateHandler() {
		self.locationManager.handleDelegateResult = self.makeCompletion()
	}

	func getCurrentLocation() {
		self.locationManager.getCurrentLocation(completion: self.makeCompletion())
	}

	func makeCompletion() -> ((Result<CLLocation, LocationError>) -> Void) {
		let completion: ((Result<CLLocation, LocationError>) -> Void) = { [weak self] result in
			switch result {
			case .success(let location):
				self?.getWeather(for: location)
			case .failure(let error):
				let alertModel = AlertModel(message: error.description) { [weak self] in
					self?.vc?.showSearchTextField()
				}
				self?.alertPresenter.showAlert(for: alertModel)
			}
		}
		return completion
	}

	func getWeather(for location: CLLocation) {
		self.networkLoader.load(location: location) { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let weather):
				self.vc?.displayWeatherData(CurrentWeatherViewModel(weather: weather))
				self.vc?.hideLoadingIndicator()
			case .failure(let error):
				let alertModel = AlertModel(message: error.description) { [weak self] in
					self?.getCurrentLocation()
				}
				self.alertPresenter.showAlert(for: alertModel)
			}
		}
	}
}
