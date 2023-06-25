// CurrentWeatherAssembly.swift
// Created by Anastasiya Kudasheva

enum CurrentWeatherAssembly {
	static func build() -> CurrentWeatherView {
		let locationManager = LocationManager()
		let networkLoader = NetworkDataLoader()
		let viewModel = CurrentWeatherViewModel(locationManager: locationManager,
												networkLoader: networkLoader)
		let view = CurrentWeatherView(viewModel: viewModel)
		return view
	}
}
