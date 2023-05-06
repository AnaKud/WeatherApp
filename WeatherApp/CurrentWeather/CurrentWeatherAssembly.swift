// CurrentWeatherAssembly.swift
// Created by Anastasiya Kudasheva

enum CurrentWeatherAssembly {
	static func buid() -> CurrentWeatherViewController {
//		let state = UIApplication().

		let locationManager = LocationManager()
		let networkLoader = NetworkDataLoader<WeatherData>()
		let alertPresenter = AlertPresenter()
		let presenter = CurrentWeatherPresenter(
			locationManager: locationManager,
			networkLoader: networkLoader,
			alertPresenter: alertPresenter
		)
		let vc = CurrentWeatherViewController(presenter: presenter)
		return vc
	}
}
