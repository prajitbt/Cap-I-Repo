//
//  whenTappedGetStartedOnSplashButton.swift
//  LegoScannerUITests
//
//  Created by Prajiton 11/22.
//

import XCTest

final class whenTappedGetStartedOnSplashButton: XCTestCase {

    private var app:XCUIApplication!
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        app.buttons["btnGetStarted"].tap()
    }
    
    override  func tearDown() {
        app = nil
    }
    
    func testIfGetStartedButtonIsPresent() throws {
        // UI tests must launch the application that they test.
        print(app.buttons.element)
        let predictButton = app.buttons.element(boundBy: 1)
        print(predictButton.label)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(predictButton.label, "Predict Image")
    }
    
    func testIfTappingChooseAImageShowsSheet() throws{
        let btnChooseLogo = app.buttons.element(boundBy: 2)
        btnChooseLogo.tap()
        print(app)
        let photoLibrary = app.buttons.element(boundBy: 4)
        print(photoLibrary)
        let camera = app.buttons["btnCamera"]
        let cmBtn = app.buttons.element(boundBy: 3)
//
        XCTAssertEqual(photoLibrary.label, "Photo Library")
        XCTAssertEqual(photoLibrary.exists, true)
        
        XCTAssertEqual(cmBtn.label, "Camera")
        XCTAssertEqual(cmBtn.exists, true)
        
}
    
    
}
