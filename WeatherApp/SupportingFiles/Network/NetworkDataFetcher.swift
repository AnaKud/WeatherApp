// NetworkDataFetcher.swift
// Created by Anastasiya Kudasheva

import CoreLocation

class NetworkDataFetcher {
	private let requestString = "https://api.openweathermap.org/data/2.5/weather?lat=%@&lon=%@&appid=ad21a8d2a372ac3a8a5439ceaf8f7687&units=metric"

	func fetchData(location: CLLocation, _ completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
		let requestString =  String(format: self.requestString,
									location.coordinate.latitude.description,
									location.coordinate.longitude.description)
		guard let url = URL(string: requestString) else { return }
		let request = URLRequest(url: url)

		URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
			guard error == nil else { return completion(.failure(.internetError)) }

			guard let data else { return completion(.failure(.emptyDataError)) }

			completion(.success(data))
		})
		.resume()
	}
}
