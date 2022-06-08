//
//  Layout.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/05/02.
//

import SwiftUI


//2022/5/2-> 부모 뷰는 사이즈를 제안하지만 실질적으로 사이즈를 결정하는 것은 자식뷰이다.  .frame이 Text 뷰의 사이즈를 결정한다.  

struct Layout: View {
    var body: some View {
        VStack {
            Text("A great and warm welcome to Kuchi")
                .background(Color.red)
                .frame(width: 100 , height: 50, alignment: .center)
                .background(.yellow)
            
            Image("welcome-background")
                .resizable()
                .background(Color.red)
                .frame(width: 100, height: 50, alignment: .center)
                .background(Color.yellow)
            
            
        }
        .background(.yellow)
        .frame(width: 300, height: 300, alignment: .center)
        
        
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        Layout()
    }
}
