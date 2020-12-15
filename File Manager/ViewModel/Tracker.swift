//
//  Tracker.swift
//  File Manager
//
//  Created by Summit on 09/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

class Tracker: ObservableObject {
    @Published var isEditModeOn: Bool = false
    
    var currentDirectory: URL = FilesManager.sandboxDirectory
    {
        didSet{
            print(currentDirectory)
        }
    }
    var triggerDirectory: URL?
}
