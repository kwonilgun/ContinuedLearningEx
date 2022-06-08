//
//  ButtonStateEx.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/09.
//

import SwiftUI

struct ButtonStateEx: View {
    
    @State private var framework: String = "UI Kit"
    var body: some View {
        Button(framework) {
            self.framework = "SwiftUI"
        }
    }
}

struct ButtonStateEx_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStateEx()
    }
}
