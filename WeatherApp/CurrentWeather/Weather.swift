// Weather.swift
// Created by Anastasiya Kudasheva

import Foundation

struct WeatherData: Codable {
	let weather: [Weather]
	let main: Main
	let wind: Wind
	let name: String
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
