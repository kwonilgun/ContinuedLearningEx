//
//  GeometryReaderBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/03.
//
/*
 
 지오 메트리 리더는 자식 뷰에 부모 뷰와 기기에 대한 크기 및 좌표계 정보를 전달하는 기능을 수행하는 컨테이너 뷰이다.
 아이폰이 회전하는 경우처럼 뷰의 크기가 변경되더라도 그 값이 자동으로 갱신된다.
 */
import SwiftUI

struct GeometryReaderBoot: View {
    
    @State var point:Int
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        
        VStack {
    
            
            GeometryReader { gNumber in
                Text("Geometry Reader")
                    .font(.largeTitle)
                    .bold()
                    .position(x: gNumber.size.width / 2,
                              y: gNumber.safeAreaInsets.top)
                VStack {
                    Text("width = \(Int(gNumber.size.width))")
                    Text("height = \(Int(gNumber.size.height))")
                }
                .font(.title)
                .position(x: gNumber.size.width/2, y: gNumber.size.height/4)
                
            }
            //frame이 실제적인 지오메트리 높이와 폭을 결정한다.
            .frame(width: .infinity, height: 400)
                                                
            
            ScrollView(.horizontal, showsIndicators: false) {

                HStack() {

                    ForEach(0..<20) { index in
                        
                        Text("\(index)")
                        GeometryReader { geometry in
                            
//                            RoundedRectangle(cornerRadius: 20)
//                                .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0.0, y: 1.0, z: 0.0))
//
                            Image("SwiftImage")
                                .resizable()
                                .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0.0, y: 1.0, z: 0.0))
                                
                        }
                        //지오메트리의 값을 폭 300, 높이 250으로 지정을 한다.
                        .frame(width: 300, height: 250)
                        .padding()
                    }
                }
            }
            Spacer()
                
          
        }
    }
}


struct GeometryReaderBoot_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBoot(point: 5)
    }
}
