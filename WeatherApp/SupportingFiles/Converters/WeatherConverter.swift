// WeatherConverter.swift
// Created by Anastasiya Kudasheva

enum WeatherConverter {
	static func convertTemperature(_ temperatureString: String) -> String {
		return temperatureString + "°"
	}

	static func convertWind(_ windString: String) -> String {
		return windString + " km/h"
	}

	static func convertHumidity(_ humidityString: String) -> String {
		return humidityString + " %"
	}
}
