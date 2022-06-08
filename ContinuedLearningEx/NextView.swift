//
//  NextView.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/05.
//

import SwiftUI

struct NextView: View {
    
    @EnvironmentObject var testData : TestData
    var body: some View {
        Text("Hello, NextView! count: \(testData.count)")
        
    }
}

    

struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
    }
}
