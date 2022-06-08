//
//  StatePrivateExample.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/05.
//

import SwiftUI

/*
 SwiftUI는 데이터 주도적 방식이다.
 이는 데이터와 내 뷰 사이에 Published - Subcriber 모델이 존재하기에 가능한 일이다.
 이를 위해 SwiftUI는 상태 프로퍼티. Observerable 객체 그리고 Enviornment 객체를
 제공하며 이들 모두는 UI 모양과 동작을 결정하는 상태를 제공한다.
 SwiftUI 내에서 UI 레이아웃을 구성하는 뷰는 코드 내에서 직접 업데이트하지 않는다.
 대신에 뷰와 바인딩된 상태 객체가 시간이 지남에 따라 현재 뷰 상황에 땨라 그 상태가
 자동으로 업데이트 된다.
 
 State 프로퍼티 @State라는 프로퍼티 래퍼를 활용한다.
    상태값은 해당 뷰에 종속되기 때문에 private 키워드를 이용해서 선언을 한다.
    상태 프로퍼티의 값이 변경이 되었다는 것은 뷰를 다시 랜더링해야 한다는 의미이다.
    상태 프로퍼티를 선언을 했다는 것은 레이아웃에 있는 뷰와 바인딩할 수 있다.
 */
struct StatePrivateExample: View {
    
    @State private var wifiEnable: Bool = true
    @State private var userName: String = ""
    
    var body: some View {
       
        VStack(spacing: 10){
            Toggle("Wifi Enable", isOn: $wifiEnable)
                .padding()
            TextField("사용자 이름", text: $userName, prompt: Text("user name"))
                .padding()
            Text("사용자이름=\(userName)")
            //Image(systemName: wifiEnable ? "wifi" : "wifi.slash")
            WifiImageView(wifiEnable: $wifiEnable)
        }
    }
}

/*
 State binding 어떤 뷰가 하나이상의 하위 뷰를 가지고 있는 동일한 상태 프로퍼티에 대한 접근이 필요한 경우가 존재하는 데 하위 뷰는 해당 상태 프로퍼티에 대한 참조가 불가능하다.
 */

struct WifiImageView: View {
    
    @Binding var wifiEnable: Bool
    
    var body: some View {
        Image(systemName: wifiEnable ? "wifi" : "wifi.slash")
    }
}

struct StatePrivateExample_Previews: PreviewProvider {
    static var previews: some View {
        StatePrivateExample()
    }
}
