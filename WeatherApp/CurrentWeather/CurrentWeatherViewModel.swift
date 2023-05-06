// CurrentWeatherViewModel.swift
// Created by Anastasiya Kudasheva

import Foundation

class CurrentWeatherViewModel {
	let city: String
	let date: String
	let temp: String
	let weatherType: WeatherType
	let wind: String
	let humidity: String

	init(weather: WeatherData) {
		self.date = DateConverter.showDayWithWeekDay(Date.now)
		self.city = weather.name
		self.temp = WeatherConverter.convertTemperature(weather.main.temp)
		self.weatherType = WeatherType(conditionCode: weather.weather.first?.id)
		self.wind = WeatherConverter.convertWind(weather.wind.speed)
		self.humidity = WeatherConverter.convertHumidity(weather.main.humidity)
	}
}
