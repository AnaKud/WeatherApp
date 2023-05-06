// AlertModel.swift
// Created by Anastasiya Kudasheva

import Foundation

struct AlertModel {
	let message: String?
	let tapHandler: (() -> Void)?

	init(message: String,
		 tapHandler: (() -> Void)? = nil) {
		self.message = message
		self.tapHandler = tapHandler
	}
}
