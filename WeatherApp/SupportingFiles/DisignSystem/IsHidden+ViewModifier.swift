// IsHidden+ViewModifier.swift
// Created by Anastasiya Kudasheva

import SwiftUI

extension View {
	func isHidden(_ hidden: Bool) -> some View {
		modifier(IsHidden(hidden: hidden))
	}
}

struct IsHidden: ViewModifier {
	var hidden = false
	func body(content: Content) -> some View {
		if hidden {
			content.hidden()
		} else {
			content
		}
	}
}
