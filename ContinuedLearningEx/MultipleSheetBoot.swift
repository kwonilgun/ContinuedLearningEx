//
//  MultipleSheetBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/03.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String

}

//1 - binding
//2 - multiple sheet
//3 - use $item

struct MultipleSheetBoot: View {
    
    @State var selectedModel: RandomModel? = nil
    //@State var showSheet: Bool = false
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20){
                ForEach(0..<50) { index in
                    Button("Button \(index)"){
                        selectedModel = RandomModel(title: "\(index)")
                        //showSheet.toggle()
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
        
        
//        VStack(spacing: 20){
//            Button("Button 1"){
//                selectedModel = RandomModel(title: "ONE")
//                //showSheet.toggle()
//            }
//            Button("Button 2"){
//                selectedModel = RandomModel(title: "TWO")
//                //showSheet.toggle()
//            }
//        }
//        .sheet(item: $selectedModel) { model in
//            NextScreen(selectedModel: model)
//        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: selectedModel)
//        }
    }
}


struct NextScreen: View {
    
   let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}


struct MultipleSheetBoot_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetBoot()
    }
}
