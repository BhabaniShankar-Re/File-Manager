//
//  FileManager.swift
//  File Manager
//
//  Created by Summit on 02/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI


extension FileManager {
    // System attributes
    private var byteCountFormatter: ByteCountFormatter {
        ByteCountFormatter()
    }
    private var systemAttributes: [FileAttributeKey: Any] {
        get {
            let attributes = try? attributesOfFileSystem(forPath: "/")
            return attributes ?? [:]
        }
    }
    
    // Application root path(Sandbox).
    var sandboxDirectory: URL {
        get {
             return temporaryDirectory.deletingLastPathComponent()
        }
    }
    
    var sandboxDirectorySize: Double {
        return calculateDirectorySize(at: sandboxDirectory)!
    }
    
    var totalSystemSize: Double {
        get {
            return systemAttributes[.systemSize] as? Double ?? 1.0
        }
    }
    
    var systemConsumedSpace: Double {
        get {
            let systemFreeSize = systemAttributes[.systemFreeSize] as? Double ?? 0.0
            return totalSystemSize - systemFreeSize
            
        }
    }
    
    var colorForSystemConsumedSpace: Color {
        get{
            let color = colorAccordingToSize(systemConsumedSpace, totalSize: totalSystemSize)
            return color
        }
    }
    
    ///  Provide color according to percentage size.
    func colorAccordingToSize(_ size: Double, totalSize: Double) -> Color {
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
    func calculateDirectorySize(at url: URL) -> Double? {
        guard let isReachable = try? url.checkResourceIsReachable(), isReachable, url.hasDirectoryPath else { return nil }
        
        let enumurater = enumerator(at: url, includingPropertiesForKeys: [.totalFileAllocatedSizeKey])
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
    
    func contentsOfDirectory(at url: URL) -> [FileModel] {
        let models = try? contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            .map({ (url) -> FileModel in
                FileModel(path: url, isDirectory: url.hasDirectoryPath)
            })
        return models ?? []
    }
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

