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
        //_filePaths = State(initialValue: FilesManager.contentsOfDirectory(at: directoryPath))
       // let dt = DirectoryMinitor(for: directoryPath, queue: .main, handler: updateFileList)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(filePaths) { item in
                    if item.isDirectory {
                        NavigationLink(
                            destination: FileListView(directoryPath: item.path),
                            label: {
                                FileView(fileName: item.name, isDirectory: item.isDirectory)
                            })
                    }else {
                        FileView(fileName: item.name, isDirectory: item.isDirectory)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .navigationBarItems(trailing: MenuView(shouldPresetntFolderView: $shouldPresentFolderview))
        .onAppear(perform: {
            tracker.currentDirectory = directoryPath
            withAnimation {
                filePaths = FilesManager.contentsOfDirectory(at: directoryPath)
            }
        })
        .createNewFolderView(isPresented: $shouldPresentFolderview)
    }
    
    func updateFileList() {
        filePaths = FilesManager.contentsOfDirectory(at: directoryPath)
    }
    
}


struct FileListView_Previews: PreviewProvider {
    
    static var previews: some View {
        FileListView(directoryPath: FilesManager.sandboxDirectory)
        
    }
}
