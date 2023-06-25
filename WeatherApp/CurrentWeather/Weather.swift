// Weather.swift
// Created by Anastasiya Kudasheva

import Foundation
import CoreLocation
import SwiftUI

struct WeatherData: Codable {
	let weather: [Weather]
	let main: Main
	let wind: Wind
	let name: String
}

extension WeatherData {
	init() {
		self.weather = []
		self.main = Main(temp: 0, humidity: 0)
		self.wind = Wind(speed: 0)
		self.name = ""
	}
}

// MARK: - Main
struct Main: Codable {
	let temp: Double
	let humidity: Int
}

// MARK: - Weather
struct Weather: Codable {
	let id: Int
}

// MARK: - Wind
struct Wind: Codable {
	let speed: Double
}
