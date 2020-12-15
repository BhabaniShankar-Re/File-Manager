//
//  ContentView.swift
//  File Manager
//
//  Created by Summit on 28/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var tracker = Tracker()
    
    var body: some View {
        NavigationView{
            VStack {
                ProgressView("Device Memory", value: FilesManager.systemConsumedSpace, total: FilesManager.totalSystemSize)
                    .accentColor(FilesManager.colorForSystemConsumedSpace)
                    .padding()
                NavigationLink(destination: FileListView(directoryPath: FilesManager.sandboxDirectory)){
                    SandBoxView()
                }
            }
            .navigationTitle(Text("File Manager"))
        }
        .environmentObject(tracker)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
