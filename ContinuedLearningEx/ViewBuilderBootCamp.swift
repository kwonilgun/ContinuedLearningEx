//
//  ViewBuilderBootCamp.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/13.
//

import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame( height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ViewBuilderBootCamp: View {
    var body: some View {
        VStack {
            
            //struct를 만들면 초기화가 되면서 뷰가 자연스럽게 만들어 진다.
            HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
            HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
            //HeaderViewGeneric(title: "Title1", content: Text("hellooo"))
            //HeaderViewGeneric(title: "Title2", content: Image(systemName: "heart.fill"))
            
            //여기서 { } 는 클로저 함수이다. 이 함수를 content로 전달해서 실행이 되게한다.
            //클로저를 만들어줘야 함수로 역할을 해서 여러가지 View를 만들어 줄 수 가 있다.
            HeaderViewGeneric(title: "Title Generic") {
                Text("Hello world")
                Image(systemName: "heart.fill")
            }
            Spacer()
        }
    }
}

struct ViewBuilderBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderBootCamp()
    }
}


//VStack 뒤에 붙어있는 {} 는 클로저이다. 그리고 앞에 있는 alignment는  함수의 매개 변수이다.
/*
 @frozen public struct VStack<Content> : View where Content : View {

     /// Creates an instance with the given spacing and horizontal alignment.
     ///
     /// - Parameters:
     ///   - alignment: The guide for aligning the subviews in this stack. This
     ///     guide has the same vertical screen coordinate for every child view.
     ///   - spacing: The distance between adjacent subviews, or `nil` if you
     ///     want the stack to choose a default distance for each pair of
     ///     subviews.
     ///   - content: A view builder that creates the content of this stack.
     @inlinable public init(alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: () -> Content)

     /// The type of view representing the body of this view.
     ///
     /// When you create a custom view, Swift infers this type from your
     /// implementation of the required ``View/body-swift.property`` property.
     public typealias Body = Never
 }
 
 여기서 init를 보면 alignment 와 spacing은 기본 값이 있는 함수의 매개 변수 이름이다. 그리고 중요한 것은
 content이고, 이것은 후행 클로저를 받는다 즉 함수를 매개변수로 받는 것이다. @ViewBuilder가 중요한 역할을 한다
 View를 리턴하는 함수가 된다.
 ViewBuilder -> 함수로 정의된 매개 변수에 뷰를 전달받아 하나 이상의 자식 뷰를 만들어내는 기능을 수행한다.
 */
