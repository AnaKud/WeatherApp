// WeatherDiaryViewModel.swift
// Created by Anastasiya Kudasheva

import Foundation

struct WeatherDiaryViewModel {
	let town: String
	let date: String
	let weatherImage: WeatherAsset
	let temperature: String
}

extension WeatherDiaryViewModel {
	init() {
		self.town = Self.randomCity()
		self.date = Self.convertDate(Date.now)
		self.weatherImage = WeatherAsset(weatherType: WeatherType.allCases.randomElement() ?? .sunny)
		self.temperature = Self.convertTemperature(0)
	}
}

private extension WeatherDiaryViewModel {
	static func convertDate(_ date: Date) -> String {
		return DateConverter.showShortDay(date)
	}

	static func convertTemperature(_ temperature: Int) -> String {
		let temperature = String(describing: Int.random(in: -20...30))
		return WeatherConverter.convertTemperature(temperature)
	}

	static func randomCity() -> String {
		return ["Novosibirsk", "Tomsk", "St.Petersburg"].randomElement() ?? "Moscow"
	}
}
