//
//  DirectoryMonitor.swift
//  File Manager
//
//  Created by Summit on 15/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import Foundation

class DirectoryMinitor {
    var onPathContentChange: () -> Void
    
    init(for path: URL, queue: DispatchQueue, handler: @escaping ()-> Void) {
        onPathContentChange = handler
    }
    
    
}
