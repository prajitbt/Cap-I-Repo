import XCTest

@testable import LegoScanner

final class LegoScannerTests: XCTestCase {
   
    var cv:ContentView!

    override  func setUp() {
        cv = ContentView()
    }
    override  func tearDown() {
        cv = nil
    }
    
    func testClassifyImage(){
        cv.classifyImage()
    }

}
