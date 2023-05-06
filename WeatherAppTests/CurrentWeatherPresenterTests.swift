// CurrentWeatherPresenterTests.swift
// Created by Anastasiya Kudasheva

import XCTest
import CoreLocation
@testable import WeatherApp

class CurrentWeatherPresenterTests: XCTestCase {
	var mockLocationManager: MockLocationManager!
	var mockNetworkLoader: MockNetworkDataLoader!
	var mockAlertPresenter: MockAlertPresenter!
	var mockViewController: MockCurrentWeatherViewController!

	override func tearDown() {
		mockLocationManager = nil
		mockNetworkLoader = nil
		mockAlertPresenter = nil
		mockViewController = nil

		super.tearDown()
	}

	func testDidLoad() {
		let sut = self.makeSut(locationResult: .success(Self.location),
							   networkResult: .success(Self.weatherData))
		// Given
		XCTAssertFalse(mockViewController.showLoadingIndicatorCalled)
		sut.didLoad(self.mockViewController)

		// Then
		XCTAssertTrue(mockAlertPresenter.didLoadCalled)
		XCTAssertTrue(mockAlertPresenter.didLoadCalled)
		XCTAssertTrue(mockLocationManager.getCurrentLocationCalled)
		XCTAssertNotNil(mockLocationManager.handleDelegateResult)
		XCTAssertTrue(mockNetworkLoader.loadCalled)
		XCTAssertTrue(mockViewController.showLoadingIndicatorCalled)
		XCTAssertTrue(mockViewController.displayWeatherDataCalled)
		XCTAssertTrue(mockViewController.hideLoadingIndicatorCalled)
	}

	func testSearchFieldTextEntered() {
		// Given
		let sut = self.makeSut(locationResult: .success(Self.location),
							   networkResult: .success(Self.weatherData))
		let searchText = "Saint Petersburg"

		// When
		sut.searchFieldTextEntered(searchText)

		// Then
		XCTAssertTrue(mockLocationManager.getLocationCalled)
		XCTAssertEqual(mockLocationManager.getLocationText, searchText)
		XCTAssertTrue(mockNetworkLoader.loadCalled)
	}

	func testShowError_ifLocationDetectionFailed() {
		// Given
		let sut = self.makeSut(locationResult: .failure(.detectionFailed),
							   networkResult: .success(Self.weatherData))

		// When
		sut.didLoad(self.mockViewController)

		// Then
		XCTAssertTrue(mockLocationManager.getCurrentLocationCalled)
		XCTAssertTrue(mockAlertPresenter.showAlertCalled)
	}
}

private extension CurrentWeatherPresenterTests {
	static let weatherData = WeatherData(weather: [Weather(id: 203)],
										 main: Main(temp: 20, humidity: 50),
										 wind: Wind(speed: 2),
										 name: "Saint Petersburg")

	static let location = CLLocation(latitude: 59.1, longitude: 31.19)

	func makeSut(locationResult: Result<CLLocation, LocationError>,
				 networkResult: Result<WeatherData, NetworkError>) -> CurrentWeatherPresenter {
		self.mockLocationManager = MockLocationManager(result: locationResult)
		self.mockNetworkLoader = MockNetworkDataLoader(result: networkResult)
		self.mockAlertPresenter = MockAlertPresenter()
		self.mockViewController = MockCurrentWeatherViewController()

		return CurrentWeatherPresenter(locationManager: mockLocationManager,
									  networkLoader: mockNetworkLoader,
									  alertPresenter: mockAlertPresenter)
	}
}
