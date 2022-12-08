//
//  LegoScannerUITests.swift
//  LegoScannerUITests
//
//  Created by [Student_Namee] on [Date].
//

import XCTest

final class testSplashScreenAppearsCorrectly: XCTestCase {
    private var app:XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    override  func tearDown() {
        app = nil
    }
    
    func testIfGetStartedButtonIsPresent() throws {
        // UI tests must launch the application that they test.
        let gettingStartedBtn = app.buttons["btnGetStarted"]
        print(gettingStartedBtn.label)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(gettingStartedBtn.label,"GET STARTED")
    }

}
