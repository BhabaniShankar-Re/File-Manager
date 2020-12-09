//
//  ContentView.swift
//  File Manager
//
//  Created by Summit on 28/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            VStack {
                ProgressView("Device Memory", value: FileManager.default.systemConsumedSpace, total: FileManager.default.totalSystemSize)
                    .accentColor(FileManager.default.colorForSystemConsumedSpace)
                    .padding()
                NavigationLink(destination: FileListView(directoryPath: FileManager.default.sandboxDirectory)){
                    SandBoxView()

                }
            }
            .navigationTitle(Text("File Manager"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
