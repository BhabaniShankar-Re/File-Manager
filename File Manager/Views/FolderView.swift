//
//  CreateFolderView.swift
//  File Manager
//
//  Created by Summit on 10/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct FolderView: View {
    @EnvironmentObject var tracker: Tracker
    @Binding var isPresented: Bool
    @State var folderName = ""
    @State var presentAlert = false
    
    var body: some View {
        VStack{
            Image("directory")
                .resizable()
                .scaledToFit()
                .padding([.leading, .trailing], 20)
            
            TextField("Folder Name", text: $folderName)
                .multilineTextAlignment(.center)
            
            Spacer()
            HStack{
                Button("Cancel") {
                    isPresented = false
                }
                Spacer()
                Button("Confirm") {
                    if folderName == "" || folderName.hasPrefix(" ") {
                        presentAlert = true
                    }else {
                        FilesManager.createDirectory(at: tracker.currentDirectory, dirName: folderName)
                        isPresented = false
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: $presentAlert) { () -> Alert in
            Alert(title: Text("Error?"), message: Text("Folder can't Create with inproper Name."), dismissButton: .cancel())
        }
        
    }
}

struct CreateFolderView_Previews: PreviewProvider {
    @State static var isPresented = true
    static let tracker = Tracker()
    
    static var previews: some View {
        FolderView(isPresented: $isPresented).environmentObject(tracker)
    }
}
