//
//  FileView.swift
//  File Manager
//
//  Created by Summit on 08/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct FileView: View {
    @EnvironmentObject var tracker: Tracker
    let fileName: String
    let isDirectory: Bool
    var imageBackgroundColor: Color {
        tracker.isEditModeOn ? .gray : .clear
    }
    var textBackgroundColor: Color {
        tracker.isEditModeOn ? .blue : .clear
    }
    
    var body: some View {
        VStack(spacing: 6){
            ZStack{
                if isDirectory{
                    Image("directory")
                        .aspectRatio(contentMode: .fit)
                        .padding([.leading, .trailing], 4)
                }else {
                    Image("file")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding([.top, .bottom], 4)
                    
                }
                
            }
            .background(imageBackgroundColor)
            .cornerRadius(6.0)
            .frame(width: 72, height: 72)
            
            Text(fileName)
                .lineLimit(2)
                .foregroundColor(Color("labelColor"))
                .multilineTextAlignment(.center)
                .truncationMode(.middle)
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .background(textBackgroundColor)
                
        }
        .frame(width: 110, height: 110)
    }
}

struct FileView_Previews: PreviewProvider {
    static var tracker = Tracker()
    
    static var previews: some View {
        VStack{
            FileView(fileName: "New Foloder", isDirectory: true).environmentObject(tracker)
            FileView(fileName: "New File", isDirectory: false).environmentObject(tracker)
        }
        
    }
}
