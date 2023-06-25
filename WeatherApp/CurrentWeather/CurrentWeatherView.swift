// CurrentWeatherView.swift
// Created by Anastasiya Kudasheva

import SwiftUI

struct CurrentWeatherView: View {
	private enum Constants {
		static let horizontalOffset: CGFloat = 32
		static let topOffset: CGFloat = 16
		static let imageSize: CGFloat = 144
		static let cornerRadius: CGFloat = 16
		static let cityNameTopOffset: CGFloat = 48
	}

	private enum Texts {
		static let currentCityPlaceholder = "Current location:"
	}

	@ObservedObject private var viewModel: CurrentWeatherViewModel

	init(viewModel: CurrentWeatherViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		ZStack {
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle(tint: Colors.white.color))
				.scaleEffect(2)
				.isHidden(!self.viewModel.isShouldShowLoading)
				.accessibilityIdentifier(UIElement.activity.rawValue)

			VStack {
				self.searchTextFieldView
					.padding(.horizontal, Constants.horizontalOffset)
					.isHidden(!self.viewModel.isShouldShowManualEntering)
				Spacer()
			}

			self.loadedDataView
				.isHidden(!self.viewModel.isShouldShowLoadedData)
		}
		.background (
			Image("Background")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.scaledToFill()
		)
		.alert(isPresented: self.$viewModel.isShouldShowError) {
			Alert(title: Text(self.viewModel.errorMessage),
				  dismissButton: .default(Text("OK")))
		}
	}

	var searchTextFieldView: some View {
		HStack {
			SearchTextField {
				self.viewModel.city = $0
			}
			.padding(.top, Constants.topOffset)
			.accessibilityIdentifier(UIElement.searchTextField.rawValue)
		}
	}

	var loadedDataView: some View {
		VStack {
			self.searchTextFieldView

			self.viewModel.weatherImage
				.frame(width: Constants.imageSize,
					   height: Constants.imageSize)
				.accessibilityIdentifier(UIElement.weatherIcon.rawValue)

			WeatherWidgetView(viewModel: self.viewModel.weatherVM)
				.padding(.top, Constants.topOffset)
				.padding(.horizontal, 0)

			Text(Texts.currentCityPlaceholder)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.bold24.font)
				.lineLimit(1)
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(UIElement.currentCityLabel.rawValue)
				.padding(.top, Constants.cityNameTopOffset)

			Text(self.viewModel.city)
				.foregroundColor(Colors.white.color)
				.font(AppFonts.regular20.font)
				.lineLimit(1)
				.minimumScaleFactor(0.3)
				.frame(alignment: .center)
				.accessibilityIdentifier(UIElement.cityLabel.rawValue)

			Spacer()
		}
		.padding(.horizontal, Constants.horizontalOffset)
	}
}

private extension CurrentWeatherView {
	enum UIElement: String {
		case activity = "activityIndicator"
		case searchTextField = "searchTextField"
		case weatherIcon = "weatherIconImageView"
		case currentCityLabel = "currentCityLabel"
		case cityLabel = "cityLabel"
	}
}
