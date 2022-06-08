//
//  DownloadingImageBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/10.
//

import SwiftUI

//codable
//background threads
//weak self
//Combine
//Published and Subscribers
//FileManager
//NSCache


struct DownloadingImageBoot: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading...")
        }
        
    }
}

struct DownloadingImageBoot_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageBoot()
    }
}
