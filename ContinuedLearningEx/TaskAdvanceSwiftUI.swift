//
//  TaskAdvanceSwiftUI.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/06/06.
//

/*
 A more advanced usage of task() is to attach some kind of Equatable identifying value – when that value changes SwiftUI will automatically cancel the previous task and create a new task with the new value. This might be some shared app state, such as whether the user is logged in or not, or some local state, such as what kind of filter to apply to some data.

 As an example, we could upgrade our messaging view to support both an Inbox and a Sent box, both fetched and decoded using the same task() modifier. By setting the message box type as the identifier for the task with .task(id: selectedBox), SwiftUI will automatically update its message list every time the selection changes.

:Task()의 고급 사용은 일종의 Equatable 식별 값을 첨부하는 것입니다. 해당 값이 변경되면 SwiftUI는 이전 작업을 자동으로 취소하고 새 값으로 새 작업을 생성합니다. 이것은 사용자가 로그인했는지 여부와 같은 일부 공유 앱 상태 또는 일부 데이터에 적용할 필터 종류와 같은 일부 로컬 상태일 수 있습니다.
 
 예를 들어, 동일한 task() 수정자를 사용하여 가져온 것과 디코딩된 받은 편지함과 보낸 상자를 모두 지원하도록 메시징 보기를 업그레이드할 수 있습니다. .Task(id: selectedBox)로 메시지 상자 유형을 작업의 식별자로 설정하면 SwiftUI는 선택이 변경될 때마다 메시지 목록을 자동으로 업데이트합니다.
 
 //💇‍♀️-> 2022년 6월 6일:  즉 뷰가 사라지면 자동적으로 CancellationError() 가 발생이 되고, 취소를 할 때도 자동으로 발생이 된다. --> 이 모든 것이 뷰가 사라지면 SwiftUI가 자체적으로 CancellationError()를 발생한다.
 
 */
import SwiftUI

struct MessageT: Decodable, Identifiable {
    let id: Int
    let user: String
    let text: String
}

struct TaskAdvanceSwiftUI: View {
    
    @State private var messages = [MessageT]()
    @State private var selectedBox = "Inbox"
    let messageBoxes = ["Inbox", "Sent"]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(messages) { message in
                        VStack(alignment: .leading) {
                            Text(message.user)
                                .font(.headline)

                            Text(message.text)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(selectedBox)

            // Our task modifier will recreate its fetchData() task whenever selectedBox changes
            // selectedBox의 값이 변경이 되면 task가 재 실행이 되고 fetchData()를 타스크 재 생성을 한다.
            .task(id: selectedBox) {
                await fetchData()
            }
            .toolbar {
                // Switch between our two message boxes
                Picker("Select a message box", selection: $selectedBox) {
                    ForEach(messageBoxes, id: \.self, content: Text.init)
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    
    
    func fetchData() async {
        do {
            let url = URL(string: "https://hws.dev/\(selectedBox.lowercased()).json")!
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([MessageT].self, from: data)
        } catch {
            messages = [
                MessageT(id: 0, user: "Failed to load message box.", text: "Please try again later.")
            ]
            
            //print("fetchData 타스크 취소 :\(error)")
        }
    }
    
    
}

struct TaskAdvanceSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        TaskAdvanceSwiftUI()
    }
}
