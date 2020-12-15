//
//  FileModel.swift
//  File Manager
//
//  Created by Summit on 08/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct _File: Identifiable {
    var id: String {
        path.absoluteString
    }
    var path: URL
    var name: String {
        return path.lastPathComponent
    }
    var isDirectory: Bool
    var isEditable: Bool = true
}
