//
//  ImageClassifierTest.swift
//  LegoScannerTests
//
//  Created by Suman on 11/27/22.
//

import XCTest
import UIKit
@testable import LegoScanner

final class ImageClassifierTest: XCTestCase {

    var ic:ImageClassifier!
    let testImgName: String = "IMG_1526";
    let failedText: String = "Could not detect anything in image.Please try again.Thank you";
    let successGreenLego:String = "This is  Green colored lego of size 2 by 4 with probablity of 99.52 Percentage"
    override func setUp() {
        ic = ImageClassifier()
    }
    
    override  func tearDown() {
        ic = nil
    }
    
    func testIfImageIsProper(){
        var sample = UIImage(named: testImgName)
        let bufferThree = sample!.convertToBuffer();
        let result: String = ic.classifyImage(imageBuffer: bufferThree);
        XCTAssertEqual(result, failedText)
    }
    
    func testIfClassifierWorks(){
        let image = UIImage(named: testImgName)
        let rimage = image!.resizeImageTo(size: CGSize(width: 224, height: 224))
        let buffImg = rimage!.convertToBuffer()
        let successRes: String = ic.classifyImage(imageBuffer: buffImg)
        XCTAssertEqual(successRes, successGreenLego)
    }

}
