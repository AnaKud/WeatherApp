// AppFonts.swift
// Created by Anastasiya Kudasheva

import SwiftUI

enum AppFonts {
	case regular20
	case regular18
	case regular100
	case bold
	case bold24

	var font: Font {
		switch self {
		case .regular20:
			return Font.custom("Overpass-Regular", size: 20)
		case .regular18:
			return Font.custom("Overpass-Regular", size: 18)
		case .bold:
			return Font.custom("Overpass-Bold", size: 20)
		case .regular100:
			return Font.custom("Overpass-Regular", size: 100)
		case .bold24:
			return Font.custom("Overpass-Bold", size: 24)
		}
	}
}
