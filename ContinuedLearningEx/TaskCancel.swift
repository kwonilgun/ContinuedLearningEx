//
//  TaskCancel.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/06/06.
//
/*
There are seven things to know when working with task cancellation:

You can explicitly cancel a task by calling its cancel() method.
Any task can check Task.isCancelled to determine whether the task has been cancelled or not.
You can call the Task.checkCancellation() method, which will throw a CancellationError if the task has been cancelled or do nothing otherwise.
Some parts of Foundation automatically check for task cancellation and will throw their own cancellation error even without your input.
If you’re using Task.sleep() to wait for some amount of time to pass, that will not honor cancellation requests – the task will still sleep even when cancelled.
If the task is part of a group and any part of the group throws an error, the other tasks will be cancelled and awaited.
If you have started a task using SwiftUI’s task() modifier, that task will automatically be canceled when the view disappears.
 
뷰가 사라지면 타스크는 자동으로 취소가 된다.
 */


/*
 SwiftUI provides a task() modifier that starts a new detached task as soon as a view appears, and automatically cancels the task when the view disappears. This is sort of the equivalent of starting a task in onAppear() then cancelling it onDisappear(), although task() has an extra ability to track an identifier and restart its task when the identifier changes.

 In the simplest scenario – and probably the one you’re going to use the most – task() is the best way to load your view’s initial data, which might be loaded from local storage or by fetching and decoding a remote URL.


 */

//💇‍♀️-> 2022년 6월 6일 -> 뷰가 사라지면 타스크는 자동으로 취소된다. 이것을 구현한 코드이다. Navigation Link를 이용해서 구현을 했다.
//💇‍♀️-> 2022년 6월 6일: NavigationLink가 시작이 될 때  즉 뷰가 사라지면 자동적으로 CancellationError() 가 발생이 되고, 취소를 할 때도 자동으로 발생이 된다. --> 이 모든 것이 뷰가 사라지면 SwiftUI가 자체적으로 CancellationError()를 발생한다.

import SwiftUI

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let text: String
}

struct TaskCancel: View {
    
    var body: some View {
        NavigationView {
            NavigationLink("TaskCancel", destination:
                TaskCancelSecondScreen())
                            .navigationTitle("Message List")
                    
            }
    }
    
}

struct TaskCancelSecondScreen: View {
    @State private var messages = [Message]()

    var body: some View {
        NavigationView {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.from)
                        .font(.headline)

                    Text(message.text)
                }
            }
            .navigationTitle("Inbox")
            .task {
                await loadMessages()
            }
        }
    }

    
    //💇‍♀️->2022년 6월 6일: NavigationLink가 시작이 될 때  즉 뷰가 사라지면 자동적으로 CancellationError() 가 발생이 되고, 취소를 할 때도 자동으로 발생이 된다. --> 이 모든 것이 뷰가 사라지면 SwiftUI가 자체적으로 CancellationError()를 발생한다.
    
    func loadMessages() async {
        do {
            let url = URL(string: "https://hws.dev/messages.json")!
            
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        } catch {
//            messages = [
//                Message(id: 0, from: "Failed to load inbox.", text: "Please try again later.")
//            ]
            
            print(" loadMessages 에러 발생 :\(error)")
        }
    }
}

struct TaskCancel_Previews: PreviewProvider {
    static var previews: some View {
        TaskCancel()
    }
}
