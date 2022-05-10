// WeatherViewModel.swift
// Created by Anastasiya Kudasheva

import Foundation
import class UIKit.UIImage

struct WeatherViewModel {
	let date: String
	let temp: String
	let weatherType: WeatherType
	let wind: String
	let humidity: String
}

extension WeatherViewModel {
	init() {
		self.date = "Today, 7 May"
		self.temp = "15" + "°"
		self.weatherType = .rain
		self.wind = "10" + " km/h"
		self.humidity = "45" + " %"
	}
}

enum WeatherType {
	case sunny
	case rain
	case snow

	var description: String {
		switch self {
		case .sunny: return "sunny"
		case .rain: return "rain"
		case .snow: return "snow"
		}
	}

	var image: UIImage? {
		switch self {
		case .sunny, .snow: return UIImage(named: self.description)
		case .rain: return UIImage(named: "drizzle")
		}
	}
}
