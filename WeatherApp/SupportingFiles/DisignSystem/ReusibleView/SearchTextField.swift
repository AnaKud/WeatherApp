// SearchTextField.swift
// Created by Anastasiya Kudasheva

import UIKit

class SearchTextField: UITextField {
	private enum Texts {
		static let searchTFPlaceholder = "Search here"
	}

	private enum Constraints {
		static let cornerRadius: CGFloat = 16
		static let emptyViewWidth = 16
	}

	init() {
		super.init(frame: .zero)
		self.setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension SearchTextField {
	func setupUI() {
		self.backgroundColor = .white
		self.layer.cornerRadius = Constraints.cornerRadius
		self.layer.masksToBounds = true
		self.attributedPlaceholder = NSAttributedString(
			string: Texts.searchTFPlaceholder,
			attributes: [
				NSAttributedString.Key.font: AppFonts.regular18.font as Any,
				NSAttributedString.Key.foregroundColor: Colors.lightBlue.value
			]
		)
		let emptyView = UIView(frame: .init(
			x: .zero,
			y: .zero,
			width: Constraints.emptyViewWidth,
			height: .zero))
		self.leftViewMode = .always
		self.leftView = emptyView
		self.rightViewMode = .always
		self.rightView = emptyView
	}
}
