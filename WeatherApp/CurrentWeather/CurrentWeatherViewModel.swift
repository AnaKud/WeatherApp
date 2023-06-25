// CurrentWeatherViewModel.swift
// Created by Anastasiya Kudasheva

import Foundation
import SwiftUI
import CoreLocation

class CurrentWeatherViewModel: ObservableObject {
	@Published private var weatherScreenState: WeatherScreenState = .loading

	// MARK: - Display Loading
	var isShouldShowLoading: Bool {
		self.weatherScreenState.isLoading
	}

	// MARK: - Display Loading
	var isShouldShowManualEntering: Bool {
		self.weatherScreenState.isOnManualEntering
	}

	// MARK: - Display Error
	var isShouldShowError: Bool {
		get {
			self.weatherScreenState.isOnError
		}
		set {
			if newValue == false {
				self.weatherScreenState = .waitForManualEntering
			}
		}
	}

	var errorMessage: String {
		if case let .error(error) = self.weatherScreenState {
			return error.description
		} else {
			return ""
		}
	}

	// MARK: - Display Current Weather
	private var weatherType: WeatherType {
		WeatherType(conditionCode: self.weather.weather.first?.id)
	}

	private var weather: WeatherData {
		if case let .loadedData(data) = self.weatherScreenState {
			return data
		} else {
			return .init()
		}
	}

	var isShouldShowLoadedData: Bool {
		self.weatherScreenState.isLoaded
	}

	var city: String {
		get {
			self.weather.name
		}
		set {
			if newValue != city {
				self.cityNameChanged(newValue)
			}
		}
	}

	var weatherImage: Image {
		weatherType.imageSUI
	}

	var weatherVM: WeatherWidgetViewModel {
		WeatherWidgetViewModel(date: DateConverter.showDayWithWeekDay(Date.now),
							   temp: WeatherConverter.convertTemperature(weather.main.temp),
							   weatherDescription: weatherType.description,
							   wind: WeatherConverter.convertWind(weather.wind.speed),
							   humidity: WeatherConverter.convertHumidity(weather.main.humidity))
	}

	// MARK: - Dependencies for View Model Actions
	private let locationManager: ILocationManager
	private let networkLoader: NetworkDataLoading

	init(locationManager: ILocationManager,
		 networkLoader: NetworkDataLoading) {
		self.locationManager = locationManager
		self.networkLoader = networkLoader

		self.configureLocationManagerDelegateHandler()
		self.getCurrentLocation()
	}
}

private extension CurrentWeatherViewModel {
	func getCurrentLocation() {
		self.locationManager.getCurrentLocation(completion: self.makeCompletion())
	}

	func cityNameChanged(_ text: String) {
		self.weatherScreenState = .loading
		self.locationManager.getLocation(for: text, completion: self.makeCompletion())
	}

	func getWeather(for location: CLLocation) {
		self.networkLoader.load(location: location) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success(let weather):
					self?.weatherScreenState = .loadedData(weather)
				case .failure(let error):
					self?.weatherScreenState = .error(error)
				}
			}
		}
	}

	// MARK: - Configuration for Location Manager Handlers
	func configureLocationManagerDelegateHandler() {
		self.locationManager.handleDelegateResult = self.makeCompletion()
	}

	func makeCompletion() -> ((Result<CLLocation, LocationError>) -> Void) {
		let completion: ((Result<CLLocation, LocationError>) -> Void) = { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success(let location):
					self?.getWeather(for: location)
				case .failure(let error):
					self?.weatherScreenState = .error(error)
				}
			}
		}
		return completion
	}
}
