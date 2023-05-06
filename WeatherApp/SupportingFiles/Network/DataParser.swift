// DataParser.swift
// Created by Anastasiya Kudasheva

import Foundation

class DataParser<T: Codable> {
	func parseData(from data: Data, _ completion: @escaping ((Result<T, NetworkError>) -> Void)) {
		do {
			let parsedData = try JSONDecoder().decode(T.self, from: data)
			completion(.success(parsedData))
		} catch {
			completion(.failure(.parsingError))
		}
	}
}
