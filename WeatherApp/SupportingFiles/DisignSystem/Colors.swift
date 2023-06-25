// Colors.swift
// Created by Anastasiya Kudasheva

import SwiftUI

enum Colors {
	case white
	case whiteBackground
	case lightBlue

	var color: Color {
		switch self {
		case .lightBlue:
			return Color(red: 0.514, green: 0.547, blue: 0.667)
		case .white:
			return Color(red: 1, green: 1, blue: 1)
		case .whiteBackground:
			return Color(red: 1, green: 1, blue: 1)
				.opacity(0.3)
		}
	}
}
