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
    @State private var isSelected: Bool = false
    
    
    let file: _File
    var onTap: (_ : _File) -> ()
    //let fileName: String
    //let isDirectory: Bool
    var imageBackgroundColor: Color {
        tracker.isEditModeOn ? .gray : .clear
    }
    var textBackgroundColor: Color {
        tracker.isEditModeOn ? .blue : .clear
    }
    var textColor: Color {
        tracker.isEditModeOn ? .white : Color("labelColor")
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0){
                VStack {
                    ZStack{
                        if file.isDirectory{
                            Image("directory")
                                .aspectRatio(contentMode: .fit)
                                .padding([.leading, .trailing], 6)
                        }else {
                            Image("file")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding([.top, .bottom], 4)
                            
                        }
                        
                        if tracker.isEditModeOn {
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.white)
                                    .imageScale(.large)
                                
                            }else {
                                Image(systemName: "circle")
                                    .foregroundColor(.init(UIColor.lightText))
                                    .imageScale(.large)
                                    .background(Circle().opacity(0.3))
                            }
                        }
                        
                    }
                    .frame(width: 80, height: 76)
                    .background(imageBackgroundColor)
                    .cornerRadius(6.0)
                    
                }
                .frame(width: geo.size.width, height: geo.size.height * 0.75)
                
                
                HStack(alignment: .center) {
                    Text(file.name)
                        .lineLimit(2)
                        .foregroundColor(textColor)
                        .multilineTextAlignment(.center)
                        .truncationMode(.middle)
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                        .padding([.leading, .trailing], 2)
                        .background(textBackgroundColor)
                }
                .frame(width: geo.size.width, height: geo.size.height * 0.25, alignment: .top)
                
            }
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
            .onTapGesture {
                onTap(file)
                isSelected.toggle()
            }
            .onReceive(tracker.$isEditModeOn) { (isOn) in
                if !isOn {
                    isSelected = false
                }
            }
//            .onLongPressGesture {
//                tracker.isEditModeOn = true
//            }
        }
        .frame(width: 110, height: 130)
    }
    
}

struct FileView_Previews: PreviewProvider {
    static var tracker: Tracker = {
        var tr = Tracker()
        tr.isEditModeOn = true
        return tr
    }()
    
    static var item = _File(path: URL(fileURLWithPath: "/user/desktop"), isDirectory: true)
    static func tap(_ item: _File) {
        
    }
    
    static var previews: some View {
        HStack{
            FileView(file: item, onTap: tap(_:)).environmentObject(tracker)
            //FileView(fileName: "New File new file dadkfdsaf ds", isDirectory: false).environmentObject(tracker)
        }
        
    }
}

