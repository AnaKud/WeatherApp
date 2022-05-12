// DateConverterTests.swift
// Created by Anastasiya Kudasheva

import XCTest
@testable import WeatherApp

class DateConverterTests: XCTestCase {
	private var sut: DateConverter!
	
	override func setUp() {
		super.setUp()
		self.sut = DateConverter()
	}
	
	override func tearDown()  {
		super.tearDown()
		self.sut = nil
	}

	func testFormatterCurrentDate() {
		XCTAssertTrue(self.sut.convertToString(Date.now).contains("Today"))
	}

	func testFormatterOtherDate() {
		let date = Date(timeIntervalSince1970: 1651513837)
		print(date)
		XCTAssertEqual(self.sut.convertToString(date), "Mon, 2 May")
	}
}
