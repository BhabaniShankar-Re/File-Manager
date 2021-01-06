//
//  MenuView.swift
//  File Manager
//
//  Created by Summit on 10/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI
import Combine

struct MenuView: View {
    @EnvironmentObject var tracker: Tracker
    @Binding var shouldPresetntFolderView: Bool
    
    var body: some View {
        if (tracker.isEditModeOn || tracker.isTransitioning) {
            return AnyView(
                Button("Cancel", action: {
                    tracker.isEditModeOn = false
                    tracker.isTransitioning = false
                    tracker.selectedItems = []
                })
            )
        }else {
            return AnyView(Menu(content: {
                Button {
                    tracker.isEditModeOn = true
                } label: {
                    Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                
                Button {
                  //  createNewFolder()
                } label: {
                    Label("Create a file", systemImage: "doc")
                }
                Button {
                    shouldPresetntFolderView = true
                } label: {
                    Label("Create a Folder", systemImage: "folder")
                }
                
                
            }, label: {
                Image(systemName: "ellipsis")
                    .frame(width: 30, height: 30)
                    .background(Color("editBackground"))
                    .cornerRadius(4)
                    .shadow(color: Color.black.opacity(0.3), radius: 6, x: 3, y: 3)
                    .shadow(color: Color.white.opacity(0.7), radius: 6, x: -3, y: -3)
            }))
        
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static let tracker = Tracker()
    @State static var isPresented = false
    
    static var previews: some View {
        MenuView(shouldPresetntFolderView: $isPresented).environmentObject(tracker)
    }
}

