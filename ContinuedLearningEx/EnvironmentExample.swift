//
//  EnvironmentExample.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/06.
//

import SwiftUI

// environmnetObject 수식어를 이용해 특정 뷰에 대한 환경요소로 Observable Objectd 모델을
//등록한다.  그럼 그 뷰를 포함한 모든 자식 뷰에서 @Environment Object 프로퍼티 래퍼를 이용해 등록해 두었던 모델에 대한 의존성을 만들 수 있다.

class UserSettings: ObservableObject {
    @Published var score = 0
    
}



struct EnvironmentExample: View {
    
    @EnvironmentObject var setting: UserSettings
    
    var body: some View {
        NavigationView{
            VStack {
                
                Text("Score = \(setting.score) ")
                
                Button("Increase Score") {
                    self.setting.score += 1
                }
                .padding()
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Reset") {
                    self.setting.score = 0
                }
                .padding()
                .background(.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                NavigationLink(destination: DetailView()) {
                    Text("Show Detail View")
                }

            }
        }
    }
}

struct DetailView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        // A text view that reads from the environment settings
        Text("Score: \(settings.score)")
        
    }
    
}




struct EnvironmentExample_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentExample().environmentObject(UserSettings())
    }
}
