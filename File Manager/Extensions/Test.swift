//
//  Test.swift
//  File Manager
//
//  Created by Summit on 12/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

/// - Tag: This File used only for test purpose

import SwiftUI

struct Test: View {
    @Binding var newVar: Bool
    @State var navigationState = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 30){
                TestOne(preVar: $newVar)
                Button("Navigation") {
                    navigationState = true
                }
                NavigationLink("NextView", destination: NextView(), isActive: $navigationState)
                
                
            }
            .navigationBarTitle("Testing")
            .navigationBarItems(leading: Menu(content: {
                Button("Here it is ") {
                    print("gotch yay")
                }
            }, label: {
                Image(systemName: "circle.fill")
            }))
            

        }
    }
}

struct Test_Previews: PreviewProvider {
    @State static var variable = true
    
    static var previews: some View {
        Test(newVar: $variable)
    }
}

struct TestOne: View {
    @Binding var preVar: Bool
    
    var body: some View {
        Text("New hello world")
    }
    
    func test() {
      //  let baseUrl = URL(string: "http://google.com")
       // let url = URL(string: "query?hello=3", relativeTo: baseUrl)
    }
}

struct NextView: View {
    
    var body: some View {
        Rectangle()
            .overlay(Circle())
            .background(Color.orange)
    }
}
