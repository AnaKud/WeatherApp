// CurrentWeatherViewModel.swift
// Created by Anastasiya Kudasheva

import Foundation

struct CurrentWeatherViewModel {
	let date: String
	let temp: String
	let weatherType: WeatherType
	let wind: String
	let humidity: String
}

extension CurrentWeatherViewModel {
	init() {
		self.date = Self.convertDate(Date.now)
		self.temp = Self.convertTemperature(0)
		self.weatherType = WeatherType.allCases.randomElement() ?? .sunny
		self.wind = Self.convertWind(0)
		self.humidity = Self.convertHumidity(0)
	}
}

private extension CurrentWeatherViewModel {
	static func convertDate(_ date: Date) -> String {
		return DateConverter.showDayWithWeekDay(date)
	}

	static func convertTemperature(_ temperature: Int) -> String {
		let temperature = String(describing: Int.random(in: -20...30))
		return WeatherConverter.convertTemperature(temperature)
	}

	static func convertWind(_ wind: Int) -> String {
		let wind = String(describing: Int.random(in: 0...20))
		return WeatherConverter.convertWind(wind)
	}

	static func convertHumidity(_ humidity: Int) -> String {
		let humidity = String(describing: Int.random(in: 20...80))
		return WeatherConverter.convertHumidity(humidity)
	}
}
