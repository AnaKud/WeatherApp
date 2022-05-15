// Assets.swift
// Created by Anastasiya Kudasheva

import UIKit

enum Weather: String, CaseIterable {
	case cloudy
	case clearCloudy
	case cold
	case rain
	case foggy
	case hail
	case hot
	case isolatedThunderstroms
	case lightwind
	case mostlyCloudy
	case partlyCloudy
	case showers
	case sleet
	case snowFlurries
	case snow
	case thunderstroms
	case tornado

	var image: UIImage? {
		return UIImage(named: self.imageName)
	}
}

private extension Weather {
	var imageName: String {
		switch self {
		case .cloudy: return "cloudy"
		case .clearCloudy: return "clear-cloudy"
		case .cold: return "cold"
		case .rain: return "drizzle"
		case .foggy: return "foggy"
		case .hail: return "hail"
		case .hot: return "hot"
		case .isolatedThunderstroms: return "isolated-thunderstroms"
		case .lightwind: return "lightwind"
		case .mostlyCloudy: return "mostly-cloudy"
		case .partlyCloudy: return "partly-cloudy"
		case .showers: return "showers"
		case .sleet: return "sleet"
		case .snowFlurries: return "snow-flurries"
		case .snow: return "snow"
		case .thunderstroms: return "thunderstroms"
		case .tornado: return "tornado"
		}
	}
}
