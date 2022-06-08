//
//  TaskRandomGenerate.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/06/06.
//

import SwiftUI

struct NumberGenerator: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = Int
    let delay: Double
    let range: ClosedRange<Int>

    init(in range: ClosedRange<Int>, delay: Double = 1) {
        self.range = range
        self.delay = delay
    }

    mutating func next() async -> Int? {
        // Make sure we stop emitting numbers when our task is cancelled
        while Task.isCancelled == false {
            try? await Task.sleep(nanoseconds: UInt64(delay) * 1_000_000_000)
            print("Generating number")
            return Int.random(in: range)
        }

        return nil
    }

    func makeAsyncIterator() -> NumberGenerator {
        self
    }
}

// This generates and displays all the random numbers we've generated.
struct DetailViewed: View {
    @State private var numbers = [String]()
    let generator = NumberGenerator(in: 1...100)

    var body: some View {
        List(numbers, id: \.self, rowContent: Text.init)
            .task {
                await generateNumbers()
            }
    }

    func generateNumbers() async {
        for await number in generator {
            numbers.insert("\(numbers.count + 1). \(number)", at: 0)
        }
    }
}

struct TaskRandomGenerate: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailViewed()) {
                Text("Start Generating Numbers")
            }
        }
    }
}

struct TaskRandomGenerate_Previews: PreviewProvider {
    static var previews: some View {
        TaskRandomGenerate()
    }
}
