// SearchTextField.swift
// Created by Anastasiya Kudasheva

import SwiftUI

struct SearchTextField: View {
	private enum Texts {
		static let searchTFPlaceholder = "Search here"
	}

	private enum Constraints {
		static let cornerRadius: CGFloat = 16
		static let emptyViewWidth: CGFloat = 16
		static let height: CGFloat = 56
	}

	@State private var text: String = ""

	private let onEditing: (String) -> Void

	init(onEditing: @escaping (String) -> Void) {
		self.onEditing = onEditing
	}

	var body: some View {
		TextField(
			"",
			text: self.$text,
			prompt: Text(Texts.searchTFPlaceholder)
				.font(AppFonts.regular18.font)
				.foregroundColor(Colors.lightBlue.color)
		)
		.onSubmit {
			self.onEditing(text)
		}
			.frame(height: Constraints.height)
			.padding(.horizontal, Constraints.emptyViewWidth)
			.background(Colors.white.color)
			.cornerRadius(Constraints.cornerRadius)
			.font(AppFonts.regular18.font)
			.foregroundColor(.black)
	}
}

struct SearchTextFieldSUI_Previews: PreviewProvider {
	static var previews: some View {
		SearchTextField(onEditing: { _ in })
	}
}
