//
//  View.swift
//  File Manager
//
//  Created by Summit on 11/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI


class FolderViewPresentationValue: ObservableObject {
    @Published var isPresented: Bool
    
    init(isPresented: Bool) {
        self.isPresented = isPresented
    }
}

extension View {
    
    public func createNewFolderView(isPresented: Binding<Bool>) -> some View {
        if isPresented.wrappedValue {
            return AnyView(ZStack{
                self

                Rectangle()
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
                    .background(Color.black)
                    .opacity(0.3)

                GeometryReader{ geo in
                    ZStack {
                        ZStack {
                            FolderView(isPresented: isPresented)
                        }
                        .frame(width: geo.size.width * 0.78, height: 350)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            })
                            
            
        }else {
            return AnyView(self)
        }
    }
}



/// Something i try designed but failed. But find better soluction above.

//extension View {
//
//    public func transParentBackgroundPopView<V>(isPresented: Binding<Bool>, _ presentView: V) -> some View  where V: View {
//        let presentationValue = FolderViewPresentationValue(isPresented: isPresented.wrappedValue)
//
//        return ZStack {
//            if isPresented.wrappedValue {
//                self
//
//                Rectangle()
//                    .ignoresSafeArea()
//                    .background(Color.gray)
//                    .opacity(0.3)
//
//                GeometryReader{ geo in
//                    ZStack {
//                        ZStack {
//                            presentView
//                                .padding()
//                                .onReceive(presentationValue.$isPresented) { (value) in
//                                    print("value received")
//                                    //isPresented.wrappedValue = value
//                                }
//                                .environmentObject(presentationValue)
//                        }
//                        .frame(width: geo.size.width * 0.78, height: 350)
//                        .background(Color.white)
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                }
//            }else {
//                self
//            }
//        }
//
//    }
//
//}



