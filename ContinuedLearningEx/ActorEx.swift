//
//  ActorEx.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/04/06.
//

import SwiftUI

//class Counter {
//    var value: Int = 0
//
//    func increment() -> Int {
//        value += 1
//        return value
//    }
//}

actor Counter {
    var value: Int = 0

    func increment() -> Int {
        value += 1
        return value
    }
}

struct ActorEx: View {
    var body: some View {
        Button("Incremnet") {
            let counter = Counter()
//            print(counter.increment())
//            print(counter.increment())
            DispatchQueue.concurrentPerform(iterations: 100) { _ in
                Task {
                    print(await counter.increment())
                }
            }
        }
    }
}

struct ActorEx_Previews: PreviewProvider {
    static var previews: some View {
        ActorEx()
    }
}
