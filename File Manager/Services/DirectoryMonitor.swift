//
//  DirectoryMonitor.swift
//  File Manager
//
//  Created by Summit on 15/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import Foundation
import Combine

class DirectoryMonitor: ObservableObject {
    private var fileDescriptor: Int32 = -1
    private var openedDirectories: [Int32] = []
    private var fileMonitorSource: DispatchSourceFileSystemObject?
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    func startMonitoring(for directory: URL) {
//        guard fileMonitorSource == nil, fileDescriptor == -1 else {
//            return
//        }
        
        // Open the Directory reference by the url
        fileDescriptor = open(directory.path, O_EVTONLY)
        openedDirectories.append(fileDescriptor)
        fileMonitorSource = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fileDescriptor, eventMask: .write, queue: DispatchQueue.fileHandler)
        
        fileMonitorSource?.setEventHandler(handler: { [weak self] in
            self?.onPathContentChange()
        })
        
        fileMonitorSource?.setCancelHandler(handler: {
            [weak self] in
            guard let strongSelf = self else { return }
            close(strongSelf.openedDirectories.first!)
            strongSelf.openedDirectories.removeFirst()
        })
        
        fileMonitorSource?.resume()
    }
    
    func stopMonitoring() {
        DispatchQueue.fileHandler.sync {
            fileMonitorSource?.cancel()
        }
        
    }
    
    func onPathContentChange() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
        
    }
    
    
}
