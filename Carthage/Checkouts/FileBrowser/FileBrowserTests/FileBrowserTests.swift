//
//  FileBrowserTests.swift
//  FileBrowserTests
//
//  Created by Roy Marmelstein on 07/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import XCTest
@testable import FileBrowser

class FileBrowserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGifFBFileParse() {
        let filePath = Bundle(for: FileBrowserTests.self).url(forResource: "3crBXeO", withExtension: "gif")!
        let file = FBFile(filePath: filePath)
        XCTAssertEqual(file.filePath, filePath)
        XCTAssertEqual(file.isDirectory, false)
        XCTAssertEqual(file.type, FBFileType.GIF)
        XCTAssertEqual(file.fileExtension, "gif")
    }
    
    func testJpgFBFileParse() {
        let filePath = Bundle(for: FileBrowserTests.self).url(forResource: "Stitch", withExtension: "jpg")!
        let file = FBFile(filePath: filePath)
        XCTAssertEqual(file.filePath, filePath)
        XCTAssertEqual(file.isDirectory, false)
        XCTAssertEqual(file.type, FBFileType.JPG)
        XCTAssertEqual(file.fileExtension, "jpg")
    }
    
    func testDirectoryFBFileParse() {
        let filePath = Bundle(for: FileBrowserTests.self).bundleURL
        let file = FBFile(filePath: filePath)
        XCTAssertEqual(file.type, FBFileType.Directory)
    }
    
    func testDirectoryContentsParse() {
        let parser = FileParser.sharedInstance
        let directoryPath = Bundle(for: FileBrowserTests.self).bundleURL
        let directoryContents = parser.filesForDirectory(directoryPath)
        XCTAssertTrue(directoryContents.count > 0)
        let stitchFile = directoryContents.filter({$0.displayName == "Stitch.jpg"}).first
        XCTAssertNotNil(stitchFile)
        if let stitchFile = stitchFile {
            XCTAssertEqual(stitchFile.type, FBFileType.JPG)
        }
    }

    func testCaseSensitiveExclusion() {
        let parser = FileParser.sharedInstance
        parser.excludesFileExtensions = ["gIf"]
        let directoryPath = Bundle(for: FileBrowserTests.self).bundleURL
        let directoryContents = parser.filesForDirectory(directoryPath)
        for file in directoryContents {
            if let fileExtension = file.fileExtension {
                XCTAssertFalse(fileExtension == "gif")
            }
        }
    }

    
}
