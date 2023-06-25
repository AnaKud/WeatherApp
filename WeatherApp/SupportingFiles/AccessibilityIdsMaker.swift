// AccessibilityIdsMaker.swift
// Created by Anastasiya Kudasheva

class AccessibilityIdsMaker {
private let separator = "_"

	func makeId(from strings: [String]) -> String {
		return strings.joined(separator: self.separator)
	}
}
