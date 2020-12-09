//
//  RootView.swift
//  File Manager
//
//  Created by Summit on 28/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

class NewList: ObservableObject {
    var name: [String] = []
}


struct FileListView: View {
    @State private var filePaths: [FileModel] = []
    
    let directoryPath: URL
    var title: String {
        if directoryPath == FileManager.default.sandboxDirectory {
            return "SandBox"
        }else { return ""}
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 110, maximum: 110), spacing: 6, alignment: .center)
    ]
    
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
        .onAppear(perform: {
            filePaths = FileManager.default.contentsOfDirectory(at: directoryPath)
        })
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        FileListView(directoryPath: FileManager.default.sandboxDirectory)
            
    }
}
