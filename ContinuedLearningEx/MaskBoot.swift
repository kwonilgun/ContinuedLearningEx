//
//  MaskBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/04.
//

import SwiftUI

struct MaskBoot: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        ZStack {
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                        //.mask(starsView)
                )
        }
    }
    
   
    
}

private extension MaskBoot {
    
    private var overlayView: some View {
        
        GeometryReader(content: { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    //.foregroundColor(.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        })
            .allowsHitTesting(false)
        
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor( rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                            print("rating=\(rating)")
                        }
                        
                    }
            }
        }
    }
    
}

struct MaskBoot_Previews: PreviewProvider {
    static var previews: some View {
        MaskBoot()
    }
}
