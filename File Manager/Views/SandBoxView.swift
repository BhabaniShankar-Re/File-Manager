//
//  CellView.swift
//  File Manager
//
//  Created by Summit on 28/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct SandBoxView: View {
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Image("appLogo").renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .foregroundColor(.orange)
                VStack{
                    HStack{
                        Text("App Sandbox")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.orange)
                    }
                    ProgressView(value: FileManager.default.sandboxDirectorySize, total: FileManager.default.systemConsumedSpace)
                        .background(Color.orange)
                        .accentColor(.green)
                        .cornerRadius(3.0)
                }  // Custom allignment
                //.progressViewStyle(DarkGreenShadowProgressViewStyle())
                .alignmentGuide(.bottom, computeValue: { dimension in
                    dimension[.bottom] * 1.25
                })
                
            }
            Spacer()
        }
        .padding(20)
    }
    
}

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        SandBoxView()
    }
}

// Define Custom Progress view Style ( Useless. ).
struct DarkGreenShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        return ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0.8, blue: 0.2),
                    radius: 1.0, x: 1.0, y: 0.0)
    }
}
