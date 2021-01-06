//
//  RootView.swift
//  File Manager
//
//  Created by Summit on 28/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI


struct FileListView: View {
    @EnvironmentObject var tracker: Tracker
    @State private var filePaths: [_File] = []
    @State private var navigateToPath: String? = nil
    @State var shouldPresentFolderview: Bool = false

    let directoryPath: URL
    
    var title: String {
        if directoryPath == FilesManager.sandboxDirectory {
            return "SandBox"
        }else { return directoryPath.lastPathComponent }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 110, maximum: 110), spacing: 6, alignment: .center)
    ]
    
    init(directoryPath: URL) {
        self.directoryPath = directoryPath
        _filePaths = State(initialValue: FilesManager.contentsOfDirectory(at: directoryPath))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filePaths) { item in
                        if item.isDirectory {
                            
                            NavigationLink(
                                destination: FileListView(directoryPath: item.path), tag: item.id, selection: $navigateToPath,
                                label: {
                                    FileView(file: item, onTap: handleTapGesture(_:))
                                        .onLongPressGesture {
                                            print("long press")
                                        }
                                })
                        }else {
                            FileView(file: item, onTap: handleTapGesture(_ :))
                        }
                    }
                    
                }
                .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 100.0, trailing: 16.0))
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
            
            if (tracker.isEditModeOn || tracker.isTransitioning) {
                ToolbarView()
                    .alignmentGuide(.bottom) { (D) -> CGFloat in
                        D[.bottom] * 1.6
                    }
                    .padding()
            }
            
        }
        .navigationBarItems(trailing: MenuView(shouldPresetntFolderView: $shouldPresentFolderview))
        .navigationBarBackButtonHidden(tracker.isEditModeOn)
        .onReceive(tracker.directoryDidChangePublisher, perform: { _ in
            withAnimation {
                filePaths = FilesManager.contentsOfDirectory(at: directoryPath)
            }
        })
        .onAppear(perform: {
            tracker.currentDirectory = directoryPath
        })
        .presentNewFolderView(isPresented: $shouldPresentFolderview)
        //.showToolbar(isActive: tracker.isEditModeOn)
    }
    
    func handleTapGesture(_ item: _File) {
        if (!tracker.isEditModeOn || tracker.isTransitioning){
            navigateToPath = item.id
        }else if tracker.isEditModeOn, !tracker.selectedItems.contains(item) {
            tracker.selectedItems.insert(item)
        }else {
            tracker.selectedItems.remove(item)
        }
    }
    
}


struct FileListView_Previews: PreviewProvider {
    static let trakcer = Tracker()
    
    static var previews: some View {
        FileListView(directoryPath: FilesManager.sandboxDirectory)
            .environmentObject(trakcer)
        
    }
}
