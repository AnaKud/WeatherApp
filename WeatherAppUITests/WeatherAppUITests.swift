// WeatherAppUITests.swift
// Created by Anastasiya Kudasheva

import XCTest

class WeatherAppUITests: XCTestCase {
	func testExample() {
		let app = XCUIApplication()
		app.launch()
		self.checkLabelExist(withId: "weatherDescribeLabel")
		self.checkLabelText(labelId: "weatherDescribeLabel", text: "rain")
		self.checkImageViewExist(withId: "weatherIconImageView")
	}
}

extension XCTestCase {
	func checkLabelExist(withId id: String) {
		let app = XCUIApplication()
		let isExist = app.staticTexts[id].exists
		XCTAssertTrue(isExist)
	}

	func checkLabelText(labelId: String, text: String) {
		let app = XCUIApplication()
		let labelText = app.staticTexts[labelId].label
		XCTAssertEqual(labelText, text)
	}

	func checkImageViewExist(withId id: String) {
		let app = XCUIApplication()
		let isExist = app.images[id].exists
		XCTAssertTrue(isExist)
	}
}
