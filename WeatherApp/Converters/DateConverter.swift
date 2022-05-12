// DateConverter .swift
// Created by Anastasiya Kudasheva

import Foundation

final class DateConverter {
	public init () { }

	func convertToString(_ date: Date) -> String {
		var result: String
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en")
		if self.isCurrentDate(date) {
			formatter.dateFormat = "d MMM"
			result = "Today, " + formatter.string(from: date)
		} else {
			formatter.dateFormat = "EE, d MMM"
			result = formatter.string(from: date)
		}
		return result
	}

	private func isCurrentDate(_ date: Date) -> Bool {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MM YYYY"
		return formatter.string(from: Date.now) == formatter.string(from: date)
	}
}
