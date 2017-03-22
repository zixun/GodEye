import UIKit
import XCTest
import AppSwizzle

class AppSwizzleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSwizzleInstanceMethod() {
        let orig = #selector(AppSwizzleTests.origSelector_testSwizzleInstanceMethod)
        let alter = #selector(AppSwizzleTests.alterSelector_testSwizzleInstanceMethod)
        AppSwizzleTests.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter)
        
        self.origSelector_testSwizzleInstanceMethod()
    }
    
    func testSwizzleClassMethod() {
        let orig = #selector(AppSwizzleTests.origSelector_testSwizzleClassMethod)
        let alter = #selector(AppSwizzleTests.alterSelector_testSwizzleClassMethod)
        AppSwizzleTests.swizzleClassMethod(origSelector: orig, toAlterSelector: alter)
        
        AppSwizzleTests.origSelector_testSwizzleClassMethod()
    }
    
    func testSwizzleInstanceMethodToAlterClass()  {
        let orig = #selector(AppSwizzleTests.origSelector_testSwizzleInstanceMethodToAlterClass)
        let alter = #selector(OtherClass.alterSelector_testSwizzleInstanceMethodToAlterClass)
        AppSwizzleTests.swizzleInstanceMethod(origSelector: orig, toAlterSelector: alter, inAlterClass: OtherClass.classForCoder())
        self.origSelector_testSwizzleInstanceMethodToAlterClass()
    }
    
    func testSwizzleClassMethodToAlterClass() {
        let orig = #selector(AppSwizzleTests.origSelector_testSwizzleClassMethodToAlterClass)
        let alter = #selector(OtherClass.alterSelector_testSwizzleClassMethodToAlterClass)
        
        AppSwizzleTests.swizzleClassMethod(origSelector: orig, toAlterSelector: alter, inAlterClass: OtherClass.classForCoder())
        
        AppSwizzleTests.origSelector_testSwizzleClassMethodToAlterClass()
    }
    
}

//MARK: testSwizzleInstanceMethod extension
extension AppSwizzleTests {
    
    func origSelector_testSwizzleInstanceMethod() {
        XCTFail("Failed")
    }
    
    func alterSelector_testSwizzleInstanceMethod() {
        XCTAssert(true, "Pass")
    }
}

//MARK: testSwizzleClassMethod extension
extension AppSwizzleTests {
    
    class func origSelector_testSwizzleClassMethod() {
        XCTFail("Failed")
    }
    
    class func alterSelector_testSwizzleClassMethod() {
        XCTAssert(true, "Pass")
    }
}

//MARK: testSwizzleInstanceMethodToAlterClass extension
extension AppSwizzleTests {
    func origSelector_testSwizzleInstanceMethodToAlterClass() {
        XCTFail("Failed")
    }
}

extension AppSwizzleTests {
    class func origSelector_testSwizzleClassMethodToAlterClass() {
         XCTFail("Failed")
    }
}


class OtherClass: NSObject {
    
    func alterSelector_testSwizzleInstanceMethodToAlterClass() {
        XCTAssert(true, "Pass")
    }
    
    class func alterSelector_testSwizzleClassMethodToAlterClass() {
        XCTAssert(true, "Pass")
    }
}
