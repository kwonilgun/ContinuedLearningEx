//
//  ViewBuilderEx.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/13.
//

/*
 ViewBuilder 함수로 정의된 매개 변수에 뷰를 전달 받아 하나 이상의 자식 뷰를 만들어 내는 기능을 수행한다.
 VStack을 만들 때 뷰 빌더 속성을 적용한 content에 단지 뷰를 나열하는 것 만으로도 쉽게 여러개의 자식 뷰를 가진 컨테이너 뷰가 만들어졌다.
 */
import SwiftUI

enum Type {
    case A
    case B
}

struct AView: View {
    var body: some View {
        Text("Hello")
    }
}

struct BView: View {
    var body: some View {
       Text("World")
    }
}

//func viewType( for type: Type) -> some View {
//    Group {
//        switch type {
//        case .A:
//            AView()
//        case .B:
//            BView()
//        }
//    }
//}

//swift function에 대해 single return type을 요구한다.

@ViewBuilder
func viewType( for type: Type) -> some View {
    
        switch type {
        case .A:
            AView()
        case .B:
            BView()
        
    }
}

struct ViewBuilderEx: View {
    var body: some View {
        VStack{
            viewType(for: .A)
            viewType(for: .B)
        }
    }
}

struct ViewBuilderEx_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderEx()
    }
}
