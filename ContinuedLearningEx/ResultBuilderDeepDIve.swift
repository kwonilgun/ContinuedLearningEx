//
//  ResultBuilderDeepDIve.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/14.
//

import SwiftUI

struct resultBuilder {
    let stack = VStack {
        Text("Hello")
        Text("World")
        Button("I'm a button") {}
    }

    func printStack() -> Void {
        print(type(of: stack))
    }
}

struct ResultBuilderDeepDIve: View {
    var body: some View {
        Text("Hello")
    }
}

struct ResultBuilderDeepDIve_Previews: PreviewProvider {
    static var previews: some View {
        ResultBuilderDeepDIve()
    }
}
