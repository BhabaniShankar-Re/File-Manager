//
//  Tracker.swift
//  File Manager
//
//  Created by Summit on 09/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI
import Combine

class Tracker: ObservableObject {
    @Published var isEditModeOn: Bool = false
    @Published var isTransitioning: Bool = false
    @Published var selectedItems: Set<_File> = []
    var transitionType: TransitionType = .none
    private var directoryMonitor = DirectoryMonitor()
    private var anyCancelable: Set<AnyCancellable> = []
    var directoryDidChangePublisher = PassthroughSubject<Void, Never>()
    

    init() {
        directoryMonitor.objectWillChange
            .sink { _ in
                self.directoryDidChangePublisher.send()
            }
            .store(in: &anyCancelable)
        $isTransitioning
            .sink { [weak self] (value) in
                if value == false {
                    self?.selectedItems = []
                }
            }
            .store(in: &anyCancelable)
    }
    
    /// Currently on which directory.
    var currentDirectory: URL = FilesManager.sandboxDirectory.deletingLastPathComponent()
    {
        willSet {
            if currentDirectory != newValue {
                directoryMonitor.stopMonitoring()
            }
        }
        didSet{
            if oldValue != currentDirectory {
                directoryMonitor.startMonitoring(for: currentDirectory)
            }
        }
    }
    
    enum TransitionType: String, Identifiable {
        var id: String {
            return self.rawValue
        }
        case delete, move, copy, none
    }
    
    /// When move, copy opeartion occured this value assigned.
    var triggerDirectory: URL?  // Don't know is it required or not.
}
