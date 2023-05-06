// CurrentWeatherScreenTests.swift
// Created by Anastasiya Kudasheva

import XCTest

class CurrentWeatherScreenTests: XCTestCase {
	private var app: XCUIApplication!

	override func setUp() {
		super.setUp()
		app = XCUIApplication()
		app.launchEnvironment["UITestStarted"] = "true"
		app.launch()
		addUIInterruptionMonitor(withDescription: "System Dialog") { (alert) -> Bool in
			if alert.exists {
				let button = alert.buttons["Allow While Using App"]
				button.tap()
				return true
			} else {
				return false
			}
		}
		app.tap()
		continueAfterFailure = false
	}

	override func tearDown() {
		super.tearDown()
		app.terminate()
		app = nil
	}

	func testAllUIElementsIsOnScreen() {
		self.dismissAlert(withId: "AlertPresenter")
		self.enterText("London", toTF: "searchTextField")

		self.checkTFExist(withId: "searchTextField")
		self.checkImageViewExist(withId: "weatherIconImageView", waitTime: 1)
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

	func testStaticTextsIsOnScreen() {
		self.dismissAlert(withId: "AlertPresenter")
		self.enterText("London", toTF: "searchTextField")
		
		self.checkLabelText(exactly: "Current location:", on: "currentCityLabel", waitTime: 1)
		self.checkLabelText(contain: "Today", on: "dateLabel")
		self.checkLabelText(contain: "°", on: "temperatureLabel")
		self.checkLabelText(contain: "km/h", on: "wind_dataLabel")
		self.checkLabelText(contain: "%", on: "humidity_dataLabel")
	}
}
