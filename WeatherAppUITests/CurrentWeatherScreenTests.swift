// CurrentWeatherScreenTests.swift
// Created by Anastasiya Kudasheva

import XCTest

class CurrentWeatherScreenTests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		self.app = XCUIApplication()
		self.app.launchEnvironment["UITestStarted"] = "true"
		self.app.launch()
		addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
			if alert.exists {
				let button = alert.buttons["Allow While Using App"]
				button.tap()
				return true
			} else {
				return false
			}
		}
		self.app.tap()
		continueAfterFailure = false
	}

	override func tearDown() {
		super.tearDown()
		self.app.terminate()
		self.app = nil
	}

	func testAllUIElementsIsOnScreen() {
		self.dismissAlert()
		self.enterText("London", toTF: "searchTextField")

		self.checkTFExist(withId: "searchTextField")
		self.checkImageViewExist(withId: "weatherIconImageView")
		self.checkLabelExist(withId: "weatherDescribeLabel")

		self.checkLabelExist(withId: "dateLabel")
		self.checkLabelExist(withId: "temperatureLabel")
		self.checkLabelExist(withId: "dateLabel")
		self.checkLabelExist(withId: "weatherDescribeLabel")

		self.checkImageViewExist(withId: "wind_imageView")
		self.checkLabelExist(withId: "wind_nameLabel")
		self.checkLabelExist(withId: "wind_separatorLabel")
		self.checkLabelExist(withId: "wind_dataLabel")

		self.checkImageViewExist(withId: "humidity_imageView")
		self.checkLabelExist(withId: "humidity_nameLabel")
		self.checkLabelExist(withId: "humidity_separatorLabel")
		self.checkLabelExist(withId: "humidity_dataLabel")

		self.checkLabelExist(withId: "currentCityLabel")
		self.checkLabelExist(withId: "cityLabel")
	}
}
