// Colors.swift
// Created by Anastasiya Kudasheva

import class UIKit.UIColor

enum Colors {
	case lightBlue

	var value: UIColor {
		switch self {
		case .lightBlue:
			return UIColor(red: 0.514, green: 0.547, blue: 0.667, alpha: 1)
		}
	}
}
