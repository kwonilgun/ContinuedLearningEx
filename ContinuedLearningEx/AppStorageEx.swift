//
//  AppStorageEx.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/06/28.
//

/*
 @AppStorage 란 SwiftUI에서 앱을 빌드할 때 우리가 사용하는 대부분의 데이터는 String 및 Integer 와 같은 유형을 통해 장치의 메모리에 저장된다.
  
  @State 및 @StateObject 와 같은 속성 래퍼를 사용할 때 변경되지 않는다. 하지만 앱을 닫으면 메모리가 해제되고 여기에 넣은 모든 데이터가 사라지게 된다.
  
 이를 방지하고 데이터를 저장하기 위해 사용되는 것이  @AppStorage 이다.
  
 @AppStorage는 SwiftUI에서 새로 생긴 속성 래퍼이다.
  
 간단히 말해서 @AppStorage는 데이터를 유지하는 속성이다.

 @AppStorage 속성 래퍼를 사용하는 방법은 아래와 같다.
 
 @AppStorage("KEY")
 privatevarNAME: TYPE=DEFAULTVALUE

 @AppStorage 키워드 뒤에 ("고유한 값")을 넣어주면 된다.

 
 OnboardingView 안에도 AppStorageEx와 마찬가지고 @AppStorage 속성 래퍼를 넣어줘야 하는데 주의해야 할 점은 키 값은 절대 다르게 작성해서는 안된다. (오타 주의!!!)
  
 그리고 끝부분의 Bool 타입 true는 기본값일 뿐 현재 코드에 영향을 주지는 않는다. 단지 코드가 잘못 넣어졌을 때 true를 기본값으로 두어 예방하는 것이다.
  
 그리고 button을 생성해 isOnboardingActive가 false로 바뀌게 해서 HomeView로 이동하는 코드이다.

 */

import SwiftUI

struct AppStorageEx: View {
    
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingActive {
                OnBoardView()
            }
            else {
                HomeView()
            }
        }
    }
}

struct HomeView: View{
    
    @AppStorage("onboarding") var isOnboardingActive: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("HomeView")
                .font(.largeTitle)
            Button(action: {
                self.isOnboardingActive = true
            }) {
                
                Text("보드뷰")
                    .font(.title)
            }
        }
    }
}


struct OnBoardView: View {
    @AppStorage("onboarding") var isOnboardingActive: Bool = true
    
    var body: some View{
        
        VStack(spacing: 20) {
            
            Text("BoardView")
            .font(.largeTitle)
            
            Button(action: {
                self.isOnboardingActive = false
            }) {
                Text("홈뷰")
                .font(.title)
                
            }
        }
    }
}

struct AppStorageEx_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageEx()
    }
}
