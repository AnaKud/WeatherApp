// CurrentWeatherViewModelTests.swift
// Created by Anastasiya Kudasheva

import XCTest
import CoreLocation
@testable import WeatherApp

class CurrentWeatherViewModelTests: XCTestCase {
	var mockLocationManager: MockLocationManager!
	var mockNetworkLoader: MockNetworkDataLoader!

	override func tearDown() {
		mockLocationManager = nil
		mockNetworkLoader = nil

		super.tearDown()
	}

	func testDataLoaded() {
		let expectation = expectation(description: #function)
		let sut = self.makeSut(locationResult: .success(Self.location),
							   networkResult: .success(Self.weatherData))

		XCTAssertTrue(sut.isShouldShowLoading)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			XCTAssertTrue(sut.isShouldShowLoadedData)
			XCTAssertTrue(self?.mockLocationManager.getCurrentLocationCalled ?? false)
			XCTAssertNotNil(self?.mockLocationManager.handleDelegateResult)
			XCTAssertTrue(self?.mockNetworkLoader.loadCalled ?? false)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 2)
	}

	func testSearchFieldTextEntered() {
		let expectation = expectation(description: #function)
		let sut = self.makeSut(locationResult: .success(Self.location),
							   networkResult: .success(Self.weatherData))
		let searchText = "Saint Petersburg"

		sut.city = searchText

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			XCTAssertTrue(self?.mockLocationManager.getLocationCalled ?? false)
			XCTAssertEqual(self?.mockLocationManager.getLocationText, searchText)
			XCTAssertTrue(self?.mockNetworkLoader.loadCalled ?? false)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 2)
	}

	func testShowError_ifLocationDetectionFailed() {
		let expectation = expectation(description: #function)
		let error = LocationError.detectionFailed
		let sut = self.makeSut(locationResult: .failure(error),
							   networkResult: .success(Self.weatherData))

		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			XCTAssertTrue(self?.mockLocationManager.getCurrentLocationCalled ?? false)
			XCTAssertTrue(sut.isShouldShowError)
			XCTAssertEqual(sut.errorMessage, error.description)
			sut.isShouldShowError = false
			XCTAssertEqual(sut.errorMessage, "")
			XCTAssertTrue(sut.isShouldShowManualEntering)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 2)
	}
}

private extension CurrentWeatherViewModelTests {
	static let weatherData = WeatherData(weather: [Weather(id: 203)],
										 main: Main(temp: 20, humidity: 50),
										 wind: Wind(speed: 2),
										 name: "Saint Petersburg")

	static let location = CLLocation(latitude: 59.1, longitude: 31.19)

	func makeSut(locationResult: Result<CLLocation, LocationError>,
				 networkResult: Result<WeatherData, NetworkError>) -> CurrentWeatherViewModel {
		self.mockLocationManager = MockLocationManager(result: locationResult)
		self.mockNetworkLoader = MockNetworkDataLoader(result: networkResult)

		return CurrentWeatherViewModel(locationManager: mockLocationManager,
									   networkLoader: mockNetworkLoader)
	}
}
