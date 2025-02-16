//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Sevde Aydın on 2/16/25.
//

import XCTest

final class WeatherAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it's important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchWeather() throws {
        // Ensure the search bar is present
        let searchField = app.textFields.matching(identifier: "searchTextField").firstMatch
        XCTAssertTrue(searchField.exists, "The search field should exist")

        // Enter a city name and trigger search
        searchField.tap()
        searchField.typeText("Istanbul\n")

        // Wait for network request and response
        let expectation = expectation(description: "Wait for weather data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)

        // Check if the weather details are displayed
        let cityName = app.staticTexts["Istanbul"]
        XCTAssertTrue(cityName.exists, "The city name should be displayed")

        // Check if weather details exist
        let weatherDetails = app.otherElements.containing(.staticText, identifier: "Istanbul").element
        XCTAssertTrue(weatherDetails.exists, "Weather details should be displayed")
    }
}

