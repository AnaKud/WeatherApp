// DateConverterTests.swift
// Created by Anastasiya Kudasheva

import XCTest
@testable import WeatherApp

class DateConverterTests: XCTestCase {
	func testShowDayWithWeekDay_WhenCurrentDate_ShouldReturnToday() {
		let date = Date()
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en")
		formatter.dateFormat = "d MMM"
		let expectedDate = formatter.string(from: date)
		let expected = "Today, " + expectedDate
		let result = DateConverter.showDayWithWeekDay(date)
		XCTAssertEqual(result, expected)
	}

	func testShowDayWithWeekDay_WhenNotCurrentDate_ShouldReturnDayWithWeekday() {
		let date = Date(timeIntervalSince1970: 1651513837)
		print(date)
		XCTAssertEqual(DateConverter.showDayWithWeekDay(date), "Mon, 2 May")
	}

	func testShowShortDay_ShouldReturnShortDay() {
		let date = Date(timeIntervalSince1970: 1651513837)
		let expected = "2 May"
		let result = DateConverter.showShortDay(date)
		XCTAssertEqual(result, expected)
	}
}
