// DateConverterTests.swift
// Created by Anastasiya Kudasheva

import XCTest
@testable import WeatherApp

class DateConverterTests: XCTestCase {
	func testFormatterCurrentDate() {
		XCTAssertTrue(DateConverter.showDayWithWeekDay(Date.now).contains("Today"))
	}

	func testFormatterOtherDate() {
		let date = Date(timeIntervalSince1970: 1651513837)
		print(date)
		XCTAssertEqual(DateConverter.showDayWithWeekDay(date), "Mon, 2 May")
	}
}
