//
//  FileView.swift
//  File Manager
//
//  Created by Summit on 08/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct FileView: View {
    let fileName: String
    let isDirectory: Bool
    
    var body: some View {
        VStack(spacing: 6){
            ZStack{
                Color.clear
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
            .cornerRadius(6.0)
            .frame(width: 72, height: 72)
            
            Text(fileName)
                .lineLimit(2)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .truncationMode(.middle)
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .background(Color.clear)
                .cornerRadius(6.0)
                
        }
        .frame(width: 110, height: 110)
    }
}

struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            FileView(fileName: "New Foloder", isDirectory: true)
            FileView(fileName: "New File", isDirectory: false)
        }
        
    }
}
