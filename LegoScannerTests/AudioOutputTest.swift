//
//  AudioOutputTest.swift
//  LegoScannerTests
//
//  Created by Suman on 11/27/22.
//

import XCTest
@testable import LegoScanner

final class AudioOutputTest: XCTestCase {

    var aout:AudioOutput!
    
    override func setUp() {
        aout = AudioOutput()
    }
    
    override func tearDown() {
        aout = nil
    }
    
    func testIfOudioIsOutputted(){
        aout.speakThePrediction(stringToSpeak: "Testing")
    }

}
