//
//  FileHandlerQueue.swift
//  File Manager
//
//  Created by Summit on 15/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import Foundation

/// Separate Queue for monitoring file event.
extension DispatchQueue {
    static let fileHandler = DispatchQueue(label: "FileHandlerQueue", attributes: .concurrent)
}
