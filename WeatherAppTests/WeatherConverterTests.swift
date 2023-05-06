// WeatherConverterTests.swift
// Created by Anastasiya Kudasheva

import XCTest
@testable import WeatherApp

class WeatherConverterTests: XCTestCase {
	func testConvertTemperature_ShouldReturnTemperatureStringWithDegreeSymbol() {
		let temperature = 22.7
		let expected = "23°"
		let result = WeatherConverter.convertTemperature(temperature)
		XCTAssertEqual(result, expected)
	}

	func testConvertWind_WhenWindIsNil_ShouldReturnZeroWindSpeedString() {
		let wind: Double? = nil
		let expected = "0 km/h"
		let result = WeatherConverter.convertWind(wind)
		XCTAssertEqual(result, expected)
	}

	func testConvertWind_WhenWindIsNotNil_ShouldReturnWindSpeedString() {
		let wind: Double? = 23.4
		let expected = "23 km/h"
		let result = WeatherConverter.convertWind(wind)
		XCTAssertEqual(result, expected)
	}

	func testConvertHumidity_ShouldReturnHumidityString() {
		let humidity = 75
		let expected = "75 %"
		let result = WeatherConverter.convertHumidity(humidity)
		XCTAssertEqual(result, expected)
	}
}
