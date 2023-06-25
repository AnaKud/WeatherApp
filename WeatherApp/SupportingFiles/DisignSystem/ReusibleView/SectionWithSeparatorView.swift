// SectionWithSeparatorView.swift
// Created by Anastasiya Kudasheva

import SwiftUI

struct SectionWithSeparatorView: View {
	enum Atmosphere {
		case wind
		case humidity

		var desctiption: String {
			switch self {
			case .wind: return "Wind"
			case .humidity: return "Hum"
			}
		}

		var imageName: String {
			switch self {
			case .wind: return "windy"
			case .humidity: return "hum"
			}
		}

		var image: Image {
			switch self {
			case .wind: return Image("windy")
			case .humidity: return Image("hum")
			}
		}
	}

	private let type: Atmosphere
	private var data: String

	init(type: Atmosphere, data: String) {
		self.type = type
		self.data = data
	}

	var body: some View {
		HStack(spacing: 0) {
			self.type.image
				.accessibilityIdentifier(self.accessibilityId(for: .imageView))
			Text(self.type.desctiption)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.regular20.font)
				.lineLimit(1)
				.scaledToFit()
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(self.accessibilityId(for: .nameLabel))

			Text("|")
				.foregroundColor(Colors.white.color)
				.font(AppFonts.regular20.font)
				.lineLimit(1)
				.scaledToFit()
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(self.accessibilityId(for: .separatorLabel))

			Text(data)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.regular20.font)
				.lineLimit(1)
				.scaledToFit()
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(self.accessibilityId(for: .dataLabel))
		}
		.padding(.vertical, Constraints.verticalPadding)
		.background(.clear)
	}
}

private extension SectionWithSeparatorView {
	private enum Constraints {
		static let verticalPadding: CGFloat = 5
	}

	enum UIElement {
		case imageView
		case nameLabel
		case separatorLabel
		case dataLabel

		var id: String {
			switch self {
			case .imageView: return "imageView"
			case .nameLabel: return "nameLabel"
			case .separatorLabel: return "separatorLabel"
			case .dataLabel: return "dataLabel"
			}
		}
	}

	func accessibilityId(for element: UIElement) -> String {
		let accessibilityIdsMaker = AccessibilityIdsMaker()

		let prefix: String
		switch self.type {
		case .humidity: prefix = "humidity"
		case .wind: prefix = "wind"
		}
		return accessibilityIdsMaker.makeId(from: [prefix, element.id])
	}
}

struct SectionWithSeparatorView_Previews: PreviewProvider {
	static var previews: some View {
		VStack(alignment: .leading) {
			SectionWithSeparatorView(type: .wind, data: "20 km/h")
			SectionWithSeparatorView(type: .humidity, data: "30 %")
		}
		.padding(.horizontal, 40)
	}
}
