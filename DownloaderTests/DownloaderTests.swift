//
//  DownloaderTests.swift
//  DownloaderTests
//
//  Created by Károly Nyisztor on 2016. 10. 15..
//  Copyright © 2016. www.leakka.com. All rights reserved.
//

import XCTest
@testable import Downloader

class DownloaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadWithExpectation() {
        
        let expect = expectation(description: "Download should succeed")
        
        if let url = URL(string: "https://httpbin.org") {
            Downloader.download(from: url, completionHandler: { (payloadURL, response, error) in
                XCTAssertNil(error, "Unexpected error occured: \(error?.localizedDescription)")
                XCTAssertNotNil(payloadURL, "No payload URL returned")
                
                expect.fulfill()
            })
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test timed out. \(error?.localizedDescription)")
        }
    }
    
    func testDownloadWithSemaphores() {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        if let url = URL(string: "https://httpbin.org") {
            Downloader.download(from: url, completionHandler: { (payloadURL, response, error) in
                XCTAssertNil(error, "Unexpected error occured: \(error?.localizedDescription)")
                XCTAssertNotNil(payloadURL, "No payload URL returned")
                
                semaphore.signal()
            })
        }
        
        let timeout = DispatchTime.now() + DispatchTimeInterval.seconds(5)
        
        if semaphore.wait(timeout: timeout) == DispatchTimeoutResult.timedOut {
            XCTFail("Test timed out")
        }
        
    }    
}












