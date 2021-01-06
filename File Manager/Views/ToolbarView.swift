//
//  ToolbarView.swift
//  File Manager
//
//  Created by Summit on 29/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var tracker: Tracker
    @State var alertFor: Tracker.TransitionType?
    @State var errorMessageComponents: [String] = []
    
    var body: some View {
        HStack{
            if !tracker.isTransitioning {
                Spacer()
                
                Button {
                    tracker.isTransitioning = true
                    tracker.transitionType = .move
                    tracker.isEditModeOn = false
                } label: {
                    Image(systemName: "square.and.arrow.up.on.square.fill")
                }
                .disabled(tracker.selectedItems.isEmpty)
                
                Spacer()
                
                Button {
                    tracker.isTransitioning = true
                    tracker.transitionType = .copy
                    tracker.isEditModeOn = false
                } label: {
                    Image(systemName: "doc.on.doc.fill")
                }
                .disabled(tracker.selectedItems.isEmpty)
                
                Spacer()
                
                Button {
                    let failedToDeleteItems = FilesManager.delete(items: tracker.selectedItems)
                    if !failedToDeleteItems.isEmpty {
                        errorMessageComponents = failedToDeleteItems
                        alertFor = .delete
                    }else {
                        tracker.isEditModeOn = false
                        // This is required to make empty selectedItems property.
                        tracker.isTransitioning = false
                    }
                } label: {
                    Image(systemName: "trash.fill")
                }
                .disabled(tracker.selectedItems.isEmpty)
                Spacer()
            }else {
                if !(tracker.transitionType == .none) {
                    Text("\(tracker.transitionType.rawValue.capitalized) here")
                        .onTapGesture {
                            if tracker.transitionType == .copy {
                                let nonCopiedItems = FilesManager.copy(fileItems: tracker.selectedItems, to: tracker.currentDirectory)
                                if !nonCopiedItems.isEmpty {
                                    errorMessageComponents = nonCopiedItems
                                    alertFor = .copy
                                }else {
                                    tracker.isTransitioning = false
                                }
                            }else if tracker.transitionType == .move {
                                let nonMovedItems = FilesManager.move(fileItems: tracker.selectedItems, to: tracker.currentDirectory)
                                if !nonMovedItems.isEmpty {
                                    errorMessageComponents = nonMovedItems
                                    alertFor = .move
                                }else {
                                    tracker.isTransitioning = false
                                }
                            }
                        }
                }
            }
        }
        .padding(12)
        .background(Color(.sRGB, white: 0.8, opacity: 1.0))
        .cornerRadius(12.0)
        .alert(item: $alertFor) { (alertType) -> Alert in
            let errorMessage = errorMessageComponents.joined(separator: ",")
            return Alert(title: Text("Error"), message: Text("File manager can't \(alertType.rawValue) these items here: \(errorMessage)"), dismissButton: .default(Text("Ok"), action: {
                tracker.isTransitioning = false
                tracker.isEditModeOn = false
            }))
        }
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack(alignment: .bottom){
            Rectangle()
                .foregroundColor(Color.red)
            
            ToolbarView()
                .alignmentGuide(.bottom, computeValue: { dimension in
                    return dimension[.bottom] * 1.3
                })
                .padding()
        }
    }
}
