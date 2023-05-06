// MockAlertPresenter.swift
// Created by Anastasiya Kudasheva

@testable import WeatherApp

class MockAlertPresenter: IAlertPresenter {
	private(set) var didLoadCalled = false
	private(set) var showAlertCalled = false

	func didLoad(_ vc: IAlertPresentable) {
		self.didLoadCalled = true
	}

	func showAlert(for model: AlertModel) {
		self.showAlertCalled = true
	}
}
