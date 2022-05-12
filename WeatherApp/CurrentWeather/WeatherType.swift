// WeatherType.swift
// Created by Anastasiya Kudasheva

import UIKit

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
