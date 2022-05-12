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
		self.temp = "15" + "°"
		self.weatherType = .rain
		self.wind = "10" + " km/h"
		self.humidity = "45" + " %"
	}
}

private extension CurrentWeatherViewModel {
	static func convertDate(_ date: Date) -> String {
		return DateConverter().convertToString(date)
	}
}
