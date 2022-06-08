//
//  ColorExtension.swift
//  RGBullysEye
//
//  Created by kwonilgun on 2022/02/02.
//

import Foundation
import SwiftUI

extension Color {
    
    //초기화 위임: 사용자 정의 이니셜라이저
    //전달인자 레이블, 매개변수, 타입
    init(rgbStruct rgb: RGB){
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
    
    static let element = Color("Element")
    static let highlight = Color("Highlight")
    static let shadow = Color("Shadow")
    
}
