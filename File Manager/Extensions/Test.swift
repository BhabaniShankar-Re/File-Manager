//
//  Test.swift
//  File Manager
//
//  Created by Summit on 12/12/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import SwiftUI

struct Test: View {
    @Binding var newVar: Bool
    
    var body: some View {
        TestOne(preVar: $newVar)
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
}
