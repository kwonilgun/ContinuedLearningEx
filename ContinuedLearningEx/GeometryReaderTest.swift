//
//  GeometryReaderTest.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/08.
//

import SwiftUI

struct GeometryReaderTest: View {
    var body: some View {
       
        GeometryReader { geometry in
            
            Text("Geometry Reader")
                .font(.largeTitle)
                .bold()
            
            VStack{
                Text("Size")
                    .bold()
                Text("width : \(Int(geometry.size.width))")
                Text("height: \(Int(geometry.size.height))")
            }
            .position(x: geometry.size.width/2, y: geometry.size.height/2.2)
            
            VStack{
                Text("SafeAreaInsects")
                    .bold()
                Text("top: \(Int(geometry.safeAreaInsets.top))")
                Text("bottom: \(Int(geometry.safeAreaInsets.bottom))")
            }
            .position(x: geometry.size.width/2, y: geometry.size.height/1.4)
            
        }
        .font(.title)
        .border(Color.green, width: 5)
    }
}

struct GeometryReaderTest_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderTest()
.previewInterfaceOrientation(.portrait)
    }
}
