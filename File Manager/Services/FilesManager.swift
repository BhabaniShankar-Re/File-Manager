//
//  FileManager.swift
//  File Manager
//
//  Created by Summit on 02/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

class FilesManager{
    
    private static var byteCountFormatter: ByteCountFormatter {
        ByteCountFormatter()
    }
    // System attributes
    private static var systemAttributes: [FileAttributeKey: Any] {
        get {
            let attributes = try? FileManager.default.attributesOfFileSystem(forPath: "/")
            return attributes ?? [:]
        }
    }
    
    // Application root path(Sandbox).
    static var sandboxDirectory: URL {
        get {
            return FileManager.default.temporaryDirectory.deletingLastPathComponent()
        }
    }
    
    static var sandboxDirectorySize: Double {
        return calculateDirectorySize(at: sandboxDirectory)!
    }
    
    static var totalSystemSize: Double {
        get {
            return systemAttributes[.systemSize] as? Double ?? 1.0
        }
    }
    
    static var systemConsumedSpace: Double {
        get {
            let systemFreeSize = systemAttributes[.systemFreeSize] as? Double ?? 0.0
            return totalSystemSize - systemFreeSize
            
        }
    }
    
    static var colorForSystemConsumedSpace: Color {
        get{
            let color = colorAccordingToSize(systemConsumedSpace, totalSize: totalSystemSize)
            return color
        }
    }
    
    ///  Provide color according to percentage size.
    static func colorAccordingToSize(_ size: Double, totalSize: Double) -> Color {
        guard totalSize > 0 else {
            return .green
        }
        let percentageSize = 100 * size / totalSize
        
        if percentageSize >= 75.0 {
            return .red
        }else if percentageSize >= 50.0 {
            return .orange
        }else if percentageSize < 15.0 && percentageSize > 0.0{
            return .gray
        }else {
            return .green
        }
    }
    // Calculate Diskspace allocated to Directory.
    static func calculateDirectorySize(at url: URL) -> Double? {
        guard let isReachable = try? url.checkResourceIsReachable(), isReachable, url.hasDirectoryPath else { return nil }
        
        let enumurater = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.totalFileAllocatedSizeKey])
        let paths = enumurater?.allObjects.compactMap({ (object) -> URL? in
            guard let path = object as? URL else { return nil }
            return path
        })
        
        
        let size = paths?.reduce(0, { (total, url) -> Int in
            let fileSize = (try? url.resourceValues(forKeys: [.totalFileAllocatedSizeKey]).totalFileAllocatedSize) ?? 0
            return total + fileSize
        }) ?? 0
        
        return Double(size)
    }
    
    static func contentsOfDirectory(at url: URL) -> [_File] {
        let models = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            .map({ (url) -> _File in
                _File(path: url, isDirectory: url.hasDirectoryPath)
            })
        return models ?? []
    }
    
    // return true on succes and return false on failure.
    @discardableResult
    static func createDirectory(at url: URL, dirName: String) -> Bool {
        let directoryURL = url.appendingPathComponent(dirName)
        do {
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: false, attributes: nil)
            return true
        }catch {
            return false
        }
    }
    
    // Both move and copy func return name of files those are not able to move or copy to destination by filemanager.
    static func move(fileItems: Set<_File>, to dst: URL) -> [String] {
        var nonMovedItems = [String]()
        for item in fileItems {
            do {
                if item.path == dst.appendingPathComponent(item.name) {
                    throw FileTransitionError.fileAlreadyExist
                }
                try FileManager.default.moveItem(at: item.path, to: dst.appendingPathComponent(item.name))
            }catch {
                nonMovedItems.append(item.name)
            }
        }
        return nonMovedItems
    }
    
    static func copy(fileItems: Set<_File>, to dst: URL) -> [String] {
        var nonCopyedItems = [String]()
        for item in fileItems {
            do {
                if item.path == dst.appendingPathComponent(item.name) {
                    throw FileTransitionError.fileAlreadyExist
                }
                try FileManager.default.copyItem(at: item.path, to: dst.appendingPathComponent(item.name))
            }catch {
                nonCopyedItems.append(item.name)
            }
        }
        return nonCopyedItems
    }
    
    static func delete(items: Set<_File>) -> [String] {
        var nonDeleteItems = [String]()
        for item in items {
            do {
                try FileManager.default.removeItem(at: item.path)
            }catch {
                nonDeleteItems.append(item.name)
            }
        }
        return nonDeleteItems
    }
    
    enum FileTransitionError: Error {
        case fileAlreadyExist
    }
}


extension FileManager {
    
}


extension String {
    var isDirectory: Bool {
        get {
            var objcBool = ObjCBool(false)
            let _ = FileManager.default.fileExists(atPath: self, isDirectory: &objcBool)
            return  objcBool.boolValue
        }
    }
}

