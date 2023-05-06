// LocationError.swift
// Created by Anastasiya Kudasheva

import Foundation

enum LocationError: ErrorPresentable {
	case noPermission
	case detectionFailed

	var description: String {
		switch self {
		case .noPermission: return "No access to current location. Check Settings. But now you can try typing city"
		case .detectionFailed: return "Can't detect your current location. Try typing city"
		}
	}
}
