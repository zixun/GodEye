import UIKit
import XCTest
import NetworkEye

class NetworkEyeTests: XCTestCase, NetworkEyeDelegate {
    
    override func setUp() {
        super.setUp()
        NetworkEye.add(observer: self)
    }
    
    override func tearDown() {
        NetworkEye.remove(observer: self)
        super.tearDown()
    }
    
    //MARK: Test Case
    func testConnection() {
        self.expectation = self.expectation(description: "testConnection")
        
        let data = try! NSURLConnection.sendSynchronousRequest(request, returning: nil)
        print(data)
        
        self.waitForExpectations(timeout: 4) { (error:Error?) in
            if (error != nil) {
                XCTFail("Expectation Failed with error: \(error)")
            }
        }
    }
    
    func testSession() {
        self.expectation = self.expectation(description: "testConfigurationSession")
        
        let session = URLSession.shared
        URLSession.shared.dataTask(with: self.request)
        let task = session.dataTask(with: self.request) { (data:Data?, response:URLResponse?, error:Error?) in
            print(response)
        }
        task.resume()
        
        self.waitForExpectations(timeout: 4) { (error:Error?) in
            if (error != nil) {
                XCTFail("Expectation Failed with error: \(error)")
            }
        }
    }
    
    func testConfigurationSession() {
        self.expectation = self.expectation(description: "testConfigurationSession")
        
        let configure = URLSessionConfiguration.default
        let session = URLSession(configuration: configure,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.current)
        let task = session.dataTask(with: self.request) { (data:Data?, response:URLResponse?, error:Error?) in
            print(response)
        }
        task.resume()
        
        self.waitForExpectations(timeout: 4) { (error:Error?) in
            if (error != nil) {
                XCTFail("Expectation Failed with error: \(error)")
            }
        }
    }
    
    func networkEyeDidCatch(with request:URLRequest?,response:URLResponse?,data:Data?) {
        XCTAssert(true, "Pass")
        self.expectation?.fulfill()
    }
    
    //MARK: Private var
    private lazy var request: URLRequest = {
        let urlString = "https://api.github.com/search/users?q=language:objective-c&sort=followers&order=desc"
        let url = URL(string: urlString)
        return URLRequest(url: url!)
    }()
    
    private var expectation:XCTestExpectation?
    
}
