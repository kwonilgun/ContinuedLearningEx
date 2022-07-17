//
//  AppleStore.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/07/17.
//

import StoreKit
import SwiftUI

//Fetch products
//Purchase product
//Update ui / Fetch Product state

class ViewModel: ObservableObject {
    func fetchProducts() {
        Task {
            do {
                let products = try await Product.
                print(products)
            }
            catch {
                print(error)
            }
        }
        
    }
}

struct AppleStore: View {
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .resizable()
                .frame(width: 70, height: 70)
            Text("Apple Store")
                .bold()
                .font(.system(size: 32))
            Image("AppleWatch")
                .resizable()
                .aspectRatio(nil, contentMode: .fit)
            Button {
                
            } label: {
                Text("Buy now")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 220, height: 50)
                    .background(.green)
                    .cornerRadius(10)
            }

        }
    }
}

struct AppleStore_Previews: PreviewProvider {
    static var previews: some View {
        AppleStore()
    }
}
