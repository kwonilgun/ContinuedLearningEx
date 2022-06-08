//
//  FunctionBuilderEx.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/10.
//
/*
 함수 빌더(Function Builder)는 swift에서 내장 도메인 특화 언어(DSL: Domain Specific Language)를 정의하도록 추가된 문법이다.
 @ViewBuilder는 함수로 정의된 매개 변수에 뷰를 전달받아 하나 이상의 자식 뷰를 만들어 내는 기능을 수행한다. 그래서 VStack을 만들 때
 뷰 빌더 속성을 적용한 content에 단지 뷰를 나열하는 것만으로도 쉽게 여러개의 자식 뷰를 가진 컨테이너 뷰를 만들어졌다. 
 */
import SwiftUI


struct MyStack<T: View>: View {
    
    let content: T
    
    
    
    init(@ViewBuilder  content: ()->T ) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content
        }
    }
}

struct FunctionBuilderEx: View {
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        MyStack {
            Color.blue
                .frame(width: 100, height: 20)
            Text("Hello World!")
                .font(.title)
            Rectangle()
                .frame(width: 250, height: 40)
        }
    }
}

struct FunctionBuilderEx_Previews: PreviewProvider {
    static var previews: some View {
        FunctionBuilderEx()
    }
}
