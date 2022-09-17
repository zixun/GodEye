//
//  FBFile.swift
//  FileBrowser
//
//  Created by Roy Marmelstein on 14/02/2016.
//  Copyright © 2016 Roy Marmelstein. All rights reserved.
//

import UIKit

/// FBFile is a class representing a file in FileBrowser
@objc open class FBFile: NSObject {
    /// Display name. String.
    @objc public let displayName: String
    // is Directory. Bool.
    public let isDirectory: Bool
    /// File extension.
    public let fileExtension: String?
    /// File attributes (including size, creation date etc).
    public let fileAttributes: NSDictionary?
    /// NSURL file path.
    public let filePath: URL
    // FBFileType
    public let type: FBFileType

    // Size
    public func size(callingQueue: DispatchQueue = DispatchQueue.main, completionHandler: @escaping (UInt64) -> Void) {
        let queue = DispatchQueue(label: "Size calculation queue")
        queue.async {
            var size: UInt64 = 0
            switch self.type {
            case .Directory:
                size = (try? FileManager.default.allocatedSizeOfDirectory(at: self.filePath)) ?? 0
            default:
                size = self.fileAttributes?.fileSize() ?? 0
            }
            callingQueue.async {
                completionHandler(size)
            }
        }
    }
    
    open func delete() {
        do {
            try FileManager.default.removeItem(at: self.filePath)
        } catch {
            print("An error occured when trying to delete file:\(self.filePath) Error:\(error)")
        }
    }
    
    /**
     Initialize an FBFile object with a filePath
     
     - parameter filePath: NSURL filePath
     
     - returns: FBFile object.
     */
    init(filePath: URL) {
        self.filePath = filePath
        let isDirectory = checkDirectory(filePath)
        self.isDirectory = isDirectory
        if self.isDirectory {
            self.fileAttributes = nil
            self.fileExtension = nil
            self.type = .Directory
        }
        else {
            self.fileAttributes = getFileAttributes(self.filePath)
            self.fileExtension = filePath.pathExtension
            if let fileExtension = fileExtension {
                self.type = FBFileType(rawValue: fileExtension) ?? .Default
            }
            else {
                self.type = .Default
            }
        }
        self.displayName = filePath.lastPathComponent 
    }
}

/**
 FBFile type
 */
public enum FBFileType: String {
    /// Directory
    case Directory = "directory"
    /// GIF file
    case GIF = "gif"
    /// JPG file
    case JPG = "jpg"
    /// PLIST file
    case JSON = "json"
    /// PDF file
    case PDF = "pdf"
    /// PLIST file
    case PLIST = "plist"
    /// PNG file
    case PNG = "png"
    /// ZIP file
    case ZIP = "zip"
    /// Any file
    case Default = "file"
    
    /**
     Get representative image for file type
     
     - returns: UIImage for file type
     */
    public func image() -> UIImage? {
        let bundle =  Bundle(for: FileParser.self)
        var fileName = String()
        switch self {
        case .Directory: fileName = "folder@2x.png"
        case .JPG, .PNG, .GIF: fileName = "image@2x.png"
        case .PDF: fileName = "pdf@2x.png"
        case .ZIP: fileName = "zip@2x.png"
        default: fileName = "file@2x.png"
        }
        let file = UIImage(named: fileName, in: bundle, compatibleWith: nil)
        return file
    }
}

/**
 Check if file path NSURL is directory or file.
 
 - parameter filePath: NSURL file path.
 
 - returns: isDirectory Bool.
 */
func checkDirectory(_ filePath: URL) -> Bool {
    var isDirectory = false
    do {
        var resourceValue: AnyObject?
        try (filePath as NSURL).getResourceValue(&resourceValue, forKey: URLResourceKey.isDirectoryKey)
        if let number = resourceValue as? NSNumber , number == true {
            isDirectory = true
        }
    }
    catch { }
    return isDirectory
}

func getFileAttributes(_ filePath: URL) -> NSDictionary? {
    let path = filePath.path
    let fileManager = FileParser.sharedInstance.fileManager
    do {
        let attributes = try fileManager.attributesOfItem(atPath: path) as NSDictionary
        return attributes
    } catch {}
    return nil
}
