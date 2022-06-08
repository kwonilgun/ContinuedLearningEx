//
//  ObservableObjectExample.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/05.
//

import SwiftUI

/*
 state property는 뷰의 상태를 저장하는 데에 이용되며 선언된 뷰에서만 사용할 수 있다.
 이러한 문제를 해결하기 위해 상태 바인딩을 통해서 부모뷰와 자식 뷰 사이의 상태 프로퍼티를
 공유한다.
 
 상태 프로퍼티는 일시적인 프로퍼티이기 때문에 부모 뷰가 사라진다면 그 상태 또한 자연스럽게
 사라진다. 이러한 경우 영구적인 데이터를 표현할 수 있도록 Obserable객체를 제공한다.
 
 “관찰가능한 오브젝트”. 말그대로 관찰이 가능한 오브젝트라는 뜻이며 이 프로토콜을 따르는 클래스나 구조체는 외부에서 관찰될 수 있는 형태를 갖추게 된다. ObservableObject 프로토콜을 따르고 내부에 @Published 래퍼 프로퍼티를 선언한다.
 
 Observable 객체는 published를 통해 게시하고 , subscribe를 통하여 게시된 프로퍼티가 변경될 때마다 업데이트를 받습니다.
 이게 가능한 이유는 Combine 프레임워크가 iOS13 부터 도입되었기 쉽게 구축할 수 있게 되었기 때문입니다. (Combine에 대해서는 따로 공부해야할 듯합니다.)


 출처: https://jeongupark-study-house.tistory.com/189 [코더가 아닌 개발자!! Why를 가지자!]
 */

import Foundation
import Combine

class TestData : ObservableObject {

    @Published var count = 0
    
    func update(){
        
        count += 1
        
    }

}


struct ObservableObjectExample: View {

    @ObservedObject var testData : TestData

    var body: some View {
        VStack(spacing: 20) {
            Text("Current testData : \(testData.count)")
            Button("+") {
                testData.update()
            }
            .frame(width: 80, height: 40, alignment: .center)
            .font(.largeTitle)
            //.background(.gray)
            //.background(RoundedRectangle(cornerRadius: 10))
            .background(.gray)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(10)
            


        }
    }
}

struct ObservableObjectExample_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectExample(testData: TestData())
    }
}
