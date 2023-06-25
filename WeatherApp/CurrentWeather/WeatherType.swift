// WeatherType.swift
// Created by Anastasiya Kudasheva

import SwiftUI

enum WeatherType {
	case cloudy
	case clearCloudy
	case cold
	case rain
	case foggy
	case hail
	case hot
	case isolatedThunderstorm
	case lightwind
	case mostlyCloudy
	case partlyCloudy
	case showers
	case sleet
	case snowFlurries
	case snow
	case sunny
	case thunderstorm
	case tornado

	init(conditionCode: Int?) {
		guard let conditionCode else {
			self = .clearCloudy
			return
		}
		switch conditionCode {
		case 200...202, 230...232:
			self = .thunderstorm
		case 210...221:
			self = .isolatedThunderstorm
		case 300...321:
			self = .showers
		case 500...504, 520...531:
			self = .rain
		case 511, 600...622:
			self = .snow
		case 701...781:
			self = .foggy
		case 800:
			self = .sunny
		case 801:
			self = .mostlyCloudy
		case 802:
			self = .partlyCloudy
		case 803...804:
			self = .cloudy
		case 900...902, 905...1000:
			self = .tornado
		case 903:
			self = .cold
		case 904:
			self = .hot
		case 906:
			self = .hail
		case 600...601:
			self = .snowFlurries
		case 611...616, 620...622:
			self = .sleet
		case 951...953:
			self = .lightwind
		default:
			self = .clearCloudy
		}
	}


	var description: String {
		switch self {
		case .sunny: return "sunny"
		case .rain: return "rain"
		case .snow: return "snow"
		case .cloudy: return "cloudy"
		case .clearCloudy: return "clear cloudy"
		case .cold: return "cold"
		case .foggy: return "foggy"
		case .hail: return "hail"
		case .hot: return "hot"
		case .isolatedThunderstorm: return "isolated thunderstroms"
		case .lightwind: return "lightwind"
		case .mostlyCloudy: return "mostly cloudy"
		case .partlyCloudy: return "partly cloudy"
		case .showers: return "showers"
		case .sleet: return "sleet"
		case .snowFlurries: return "snow flurries"
		case .thunderstorm: return "thunderstroms"
		case .tornado: return "tornado"
		}
	}

	var imageSUI: Image {
		WeatherAsset(weatherType: self).imageSUI
	}
}

extension WeatherType: Equatable { }
