// WeatherScreenState.swift
// Created by Anastasiya Kudasheva

import Foundation

enum WeatherScreenState {
	case loadedData(WeatherData)
	case loading
	case waitForManualEntering
	case error(ErrorPresentable)

	var isLoading: Bool {
		switch self {
		case .loading: return true
		default: return false
		}
	}

	var isLoaded: Bool {
		switch self {
		case .loadedData: return true
		default: return false
		}
	}

	var isOnManualEntering: Bool {
		switch self {
		case .waitForManualEntering: return true
		default: return false
		}
	}

	var isOnError: Bool {
		switch self {
		case .error: return true
		default: return false
		}
	}
}
