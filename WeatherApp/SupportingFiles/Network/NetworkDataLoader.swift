// NetworkDataLoader.swift
// Created by Anastasiya Kudasheva

import CoreLocation

protocol NetworkDataLoading: AnyObject {
	func load(location: CLLocation,
			  _ completion: @escaping ((Result<WeatherData, NetworkError>) -> Void))
}

class NetworkDataLoader {
	private let networkDataFetcher = NetworkDataFetcher()
	private let dataParser = DataParser<WeatherData>()
}

extension NetworkDataLoader: NetworkDataLoading {
	func load(location: CLLocation,
			  _ completion: @escaping ((Result<WeatherData, NetworkError>) -> Void)) {
		networkDataFetcher.fetchData(location: location) { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let data):
				self.dataParser.parseData(from: data, completion)
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
