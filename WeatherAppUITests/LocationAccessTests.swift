// LocationAccessTests.swift
// Created by Anastasiya Kudasheva

import XCTest

class LocationAccessTests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		app = XCUIApplication()
		app.resetAuthorizationStatus(for: .location)
		app.launch()
	}

	override func tearDown() {
		super.tearDown()
		app.terminate()
		app = nil
	}

	func testScreenDisplay_LocationAccessGranted() {
		addUIInterruptionMonitor(withDescription: "System Dialog") { [weak self] (alert) -> Bool in
			guard let self else { return false }
			XCTAssertTrue(alert.exists)
			let button = alert.buttons["Allow While Using App"]
			XCTAssertTrue(button.exists)
			button.tap()
			self.checkAlertText("Can't detect your current location. Try typing city",
								withId: "AlertPresenter")
			self.dismissAlert(withId: "AlertPresenter")
			self.checkTFExist(withId: "searchTextField")
			return true
		}
		app.tap()
	}

	func testScreenDisplay_afterLocationAccessDenied() {
		addUIInterruptionMonitor(withDescription: "System Dialog") { [weak self] (alert) -> Bool in
			guard let self else { return false }
			XCTAssertTrue(alert.exists)
			let button = alert.buttons["Don’t Allow"]
			XCTAssertTrue(button.exists)
			button.tap()

			self.checkAlertText("No access to current location. Check Settings. But now you can try typing city",
								withId: "AlertPresenter")

			self.dismissAlert(withId: "AlertPresenter")
			self.checkTFExist(withId: "searchTextField")

			return true
		}
		app.tap()
	}
}
