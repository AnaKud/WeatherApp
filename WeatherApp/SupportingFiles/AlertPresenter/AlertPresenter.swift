// AlertPresenter.swift
// Created by Anastasiya Kudasheva

import UIKit

protocol IAlertPresenter: AnyObject {
	func didLoad(_ vc: IAlertPresentable)
	func showAlert(for model: AlertModel)
}

class AlertPresenter: IAlertPresenter {
	private weak var vc: IAlertPresentable?

	func didLoad(_ vc: IAlertPresentable) {
		self.vc = vc
	}

	func showAlert(for model: AlertModel) {
		let alert = UIAlertController(
			title: nil,
			message: model.message,
			preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
			model.tapHandler?()
		})
		alert.view.accessibilityIdentifier = "AlertPresenter"
		DispatchQueue.main.async { [weak self] in
			self?.vc?.present(alert, animated: true)
		}
	}
}
