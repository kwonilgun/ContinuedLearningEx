//
//  TaskAsyn_0407.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/04/07.
//


import SwiftUI

struct TaskAsyn_0407: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding()
            .onAppear {
                Task {
                    await executeTask()
                }
            }
    }
}

func executeTask() async {
    let basicTask = Task {
        return "This is the result of the task"
    }
    print(await basicTask.value)
}

struct TaskAsyn_0407_Previews: PreviewProvider {
    static var previews: some View {
        TaskAsyn_0407()
    }
}
