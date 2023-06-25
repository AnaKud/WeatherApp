// WeatherWidgetView.swift
// Created by Anastasiya Kudasheva

import SwiftUI

class WeatherWidgetViewModel: ObservableObject {
	let date: String
	let temp: String
	let weatherDescription: String
	let wind: String
	let humidity: String

	init(date: String,
		 temp: String,
		 weatherDescription: String,
		 wind: String,
		 humidity: String) {
		self.date = date
		self.temp = temp
		self.weatherDescription = weatherDescription
		self.wind = wind
		self.humidity = humidity
	}
}

extension WeatherWidgetViewModel: Equatable {
	static func == (lhs: WeatherWidgetViewModel, rhs: WeatherWidgetViewModel) -> Bool {
		return lhs.date == rhs.date &&
		lhs.temp == rhs.temp &&
		lhs.weatherDescription == rhs.weatherDescription &&
		lhs.wind == rhs.wind &&
		lhs.humidity == rhs.humidity 
	}
}

struct WeatherWidgetView: View {
	private enum Constraints {
		static let separatorSectionTopOffset: CGFloat = 24
		static let verticalOffset: CGFloat = 8
	}

	private enum Constants {
		static let corner: CGFloat = 16
		static let lineWidth: CGFloat = 2
	}

	@ObservedObject private var viewModel: WeatherWidgetViewModel

	init(viewModel: WeatherWidgetViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		VStack {
			Text(self.viewModel.date)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.regular18.font)
				.lineLimit(1)
				.scaledToFit()
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(UIElement.dateLabel.rawValue)
				.padding(.top, Constraints.verticalOffset)

			Text(self.viewModel.temp)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.regular100.font)
				.lineLimit(1)
				.scaledToFit()
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(UIElement.temperatureLabel.rawValue)

			Text(self.viewModel.weatherDescription)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.bold24.font)
				.lineLimit(1)
				.scaledToFit()
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(UIElement.weatherDescribeLabel.rawValue)

			SectionWithSeparatorView(type: .wind,
										data: self.viewModel.wind)
				.padding(.top, Constraints.separatorSectionTopOffset)

			SectionWithSeparatorView(type: .humidity,
										data: self.viewModel.humidity)
				.padding(.bottom, Constraints.verticalOffset)
		}
		.frame(maxWidth: .infinity)
		.background(Colors.whiteBackground.color)
		.cornerRadius(Constants.corner)
		.overlay(
			RoundedRectangle(cornerRadius: Constants.corner)
				.stroke(Colors.white.color,
						lineWidth: Constants.lineWidth)
			)
	}
}

private extension WeatherWidgetView {
	enum UIElement: String {
		case dateLabel = "dateLabel"
		case temperatureLabel = "temperatureLabel"
		case weatherDescribeLabel = "weatherDescribeLabel"
	}
}

struct WeatherWidgetView_Previews: PreviewProvider {
	static var previews: some View {
		VStack(alignment: .center, spacing: 0) {
			WeatherWidgetView(viewModel: .init(date: "Today, 7 May",
											   temp: "10°",
											   weatherDescription: "cloudy",
											   wind: "3 km/h",
											   humidity: "40 %"))
			.scaledToFit()
		}
	}
}
