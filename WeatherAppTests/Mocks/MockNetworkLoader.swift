// MockNetworkLoader.swift
// Created by Anastasiya Kudasheva

@testable import WeatherApp
import CoreLocation

class MockNetworkDataLoader: NetworkDataLoading {
	private(set) var loadCalled = false

	private let result: Result<WeatherData, NetworkError>

	init(result: Result<WeatherData, NetworkError>) {
		self.result = result
	}

	func load(location: CLLocation,
			  _ completion: @escaping ((Result<WeatherData, NetworkError>) -> Void)) {
		self.loadCalled = true
		completion(self.result)
	}
}
