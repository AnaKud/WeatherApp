// MockLocationManager.swift
// Created by Anastasiya Kudasheva

@testable import WeatherApp
import CoreLocation

class MockLocationManager: ILocationManager {
	private(set) var getCurrentLocationCalled = false
	private(set) var getLocationCalled = false
	private(set) var getLocationText = ""

	private let result: Result<CLLocation, LocationError>

	var handleDelegateResult: ((Result<CLLocation, LocationError>) -> Void)?

	init(result: Result<CLLocation, LocationError>) {
		self.result = result
	}

	func getCurrentLocation(completion: @escaping ((Result<CLLocation, LocationError>) -> Void)) {
		self.getCurrentLocationCalled = true
		completion(result)
	}

	func getLocation(for place: String, completion: @escaping ((Result<CLLocation, LocationError>) -> Void)) {
		self.getLocationCalled = true
		self.getLocationText = place
		completion(result)
	}
}
