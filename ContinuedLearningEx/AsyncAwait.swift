//
//  AsyncAwait.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/04/05.
//

//Asynchronous Functions을 이용해서
import SwiftUI

struct PostModelC: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ContentViewModel: ObservableObject {
    
    @Published var isFetching = true
    @Published var courses = [PostModelC]()
    
    
    init() {
        //여기서 잠시 큐에 등록을 해 놓고, 1초 뒤에 값이 변경이 되도록 한다.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.isFetching = true
//        }
        self.isFetching = true
    }
    
    //async 함수는 중간에 await가 있어서 네트웍 데이타를 받는 동안에는 기다리는 코드가 들어있다.
    
    //‘it can also pause in the middle when it’s waiting for something. Inside the body of an asynchronous function or method, you mark each of these places where execution can be suspended.’
    
    //throw와 비슷한 구조이다. 함수를 throw로 선언을 하면 에러가 발생하는 경우 return 대신에 throw를 콜한다. 여기서는 async가 선언이 된 경우는 중간에 await를 구현할 수 있다. 여기서 데이타 다운로드를 하는 동안 기다리겠다는 것이다.
    
    func fetchData() async {
        self.isFetching = false
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
            else { return }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            //print("응답: \(response)")
            //print("데이터:\(data)")
            //[PostModelC].self는 타입을 나타낸다. 타입 이름 뒤에 .self는 타입을 나타낸다. 
            
            //5초 동안 sleep 한다. 백 그라운드에서 sleeping 하는 것이다 그리고 self.courses를 update 하고 화면을 다시 그리는 것이다.
            
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            
            
            self.courses = try JSONDecoder().decode([PostModelC].self, from: data)
            
            //print(courses)
            
        }   catch {
            print("에러:\(error)")
        }
        
    }
    
}



struct AsyncAwait: View {
    
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if vm.isFetching {
                    Text("is Fetching data from internet")
                }
                
                ForEach(vm.courses) { post in
                    VStack(alignment: .leading, spacing: 10){
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .foregroundColor(.gray)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("Course")
            .task {
                //async 함수를 콜한다. 백 그라운드로 함수를 돌린다. 함수가 완료가 되면 vm.courses를 update 하기 때문에 이것이 reactive 하게 동작을 해서 다시 화면을 redraw 하게 된다.
                await vm.fetchData()
            }
        }
    }
}

struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait()
    }
}
