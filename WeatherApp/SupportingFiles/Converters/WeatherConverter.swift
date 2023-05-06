// WeatherConverter.swift
// Created by Anastasiya Kudasheva

enum WeatherConverter {
	static func convertTemperature(_ temperature: Double) -> String {
		let temperatureString = String(format: "%.0f", temperature)
		return temperatureString + "°"
	}

	static func convertWind(_ wind: Double?) -> String {
		let windString = String(format: "%.0f", wind ?? 0)
		return windString + " km/h"
	}

	static func convertHumidity(_ humidity: Int) -> String {
		return "\(humidity)" + " %"
	}
}
