// XCTestCase+Extension.swift
// Created by Anastasiya Kudasheva

import XCTest

// MARK: - SkipActions
extension XCTestCase {
	func dismissAlert(withId id: String) {
		let app = XCUIApplication()
		let alert = app.alerts[id]
		alert.buttons["OK"].tap()

		XCTAssertFalse(alert.exists)
	}

	func checkAlertText(_ text: String, withId id: String) {
		let app = XCUIApplication()
		let alertText = app.alerts[id].staticTexts[text].label

		XCTAssertEqual(alertText, text)
	}

	func checkTFExist(withId id: String, waitTime: Double = 0) {
		let app = XCUIApplication()
		XCTAssertTrue(app.textFields[id].waitForExistence(timeout: waitTime))
	}

	func enterText(_ text: String, toTF tfId: String) {
		let app = XCUIApplication()
		let textField = app.textFields[tfId]
		textField.tap()
		textField.typeText(text)
		app.buttons["Return"].tap()
	}

	func checkLabelExist(withId id: String, waitTime: Double = 0) {
		let app = XCUIApplication()
		XCTAssertTrue(app.staticTexts[id].waitForExistence(timeout: waitTime))
	}

	func checkLabelText(exactly text: String, on labelId: String, waitTime: Double = 0) {
		let app = XCUIApplication()
		let label = app.staticTexts[labelId]
		XCTAssertTrue(label.waitForExistence(timeout: waitTime))
		XCTAssertEqual(label.label, text)
	}

	func checkLabelText(contain text: String, on labelId: String) {
		let app = XCUIApplication()
		let labelText = app.staticTexts[labelId].label
		XCTAssertTrue(labelText.contains(text))
	}

	func checkImageViewExist(withId id: String, waitTime: Double = 0) {
		let app = XCUIApplication()
		XCTAssertTrue(app.images[id].waitForExistence(timeout: waitTime))
	}
}
