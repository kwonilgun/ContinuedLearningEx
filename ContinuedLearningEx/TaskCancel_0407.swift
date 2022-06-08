//
//  TaskCancel_0407.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/04/07.
//

import SwiftUI

//class TaskSettings: ObservableObject {
//    @Published var task : Task<UIImage?, Error>?
//
//    init(task: Task<UIImage?, Error>) {
//        self.task = task
//    }
//
//}

struct TaskCancel_0407: View {
    @State var image: UIImage?
    @AppStorage("count") var flag =  false
//    @EnvironmentObject var taskSetting: TaskSettings
    
    let circleSize: CGFloat = 0.275
    let labelHeight: CGFloat = 0.06
    let labelWidth: CGFloat = 0.53
    let buttonWidth: CGFloat = 0.87
    
    //@State var imageTask: Task<<#Success: Sendable#>, <#Failure: Error#>>
    
    @State var task = Task { }
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
                
                if let image = image {
                    Image(uiImage: image)
                } else {
                    VStack {
                        
                        Spacer()
                        //Text("Loading...")
                        Button(action: {
                            print("업로드 누름")
                           task =  Task {
                                do {
                                    
                                    //💇‍♀️ 2022년 6월 4일 -> 기다렸던 이미지가 오면 image에 저장을 하는 순간 reactive 하게 화면을 다시 그리게 된다. 이부분이 동작의 핵심이다.
                                    image = try await fetchImage()
                                    
                                } catch {
                                    print("4. Image loading failed:\(error)")
                                }
                               
                               
                            }
                            
                            print("업로드 타입: \(type(of: task))")
                        }, label: {
                            Text("사진 업로드")
                            
                        })
                        .buttonStyle(NewButtonStyle(width: proxy.size.width * buttonWidth,
                                                    height: proxy.size.height * labelHeight))
                        
                        //중단 버튼
                        
                        Button {
                            print("중단 버튼을 누름")
                            //taskSetting.task!.cancel()
                            //print(type(of: task))
                            task.cancel()
                            
                        } label: {
                            Text("중단")
                        }
                        .buttonStyle(NewButtonStyle(width: proxy.size.width * buttonWidth,
                                                    height: proxy.size.height * labelHeight))
                        Spacer()
                    }
                    
                }
                
            }
            .onAppear {
                 
            }
        }
    }
    
    // 💇‍♀️ 2022년 6월 4일 -> 이것을 해석하면 fetchImage()는 함수이다. async 함수이다. 그렇게 되면 imageTask에 백드라운드 타스크를 결국 백그라운에서 Task(priority: .background) { () -> UIImage?... 이 부분에서 결과 값을 가져오기 까지 시간이 걸리기 때문에 try await fetchImage()를 call 했다. 데이타를 받아와서 최종적으로 imageTask에 저장을 한다. 네트웍으로 URL로 데이타를 받아오고 UIImage로 리턴을 한다.
    
    func fetchImage() async throws -> UIImage? {
        
        //() -> UIImage? : 클로저 안에 있는 이 부분이 중요하다. 결국 타스크의 실행 결과는 UIImage? 가 리턴이 된다.
        
        let imageTask = Task(priority: .background) { () -> UIImage? in
            let imageURL = URL(string:"https://source.unsplash.com/random")!
        
            do {
                //여기서 5초 기다린다.
                
                try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
                try Task.checkCancellation()
                /// Throw an error if the task was already cancelled.
                
                print("Starting network request...")
                let (imageData, _) = try await URLSession.shared.data(from: imageURL)
                return UIImage(data: imageData)
            }
            catch {
                print("2. 취소 발생:\(error)")
                throw error
            }
            
        }
        
        // Cancel the image request right away:
        DispatchQueue.main.asyncAfter (deadline: .now() + 4) {
            print("1. dispatch 시작")
            imageTask.cancel()
        }
        
        
        //💇‍♀️ 2022년 6월 4일 -> 이 부분이 핵심이다. 이미지 데이타를 가져오는 데 시간이 걸리기 때문에 여기서 데이타를 가져올 때 까지 기다려 준다.
        
        do {
            return try await imageTask.value
        }
        catch {
            print("3. 이미지 에러 ")
            throw error
        }
    }
}

struct TaskCancel_0407_Previews: PreviewProvider {
    static var previews: some View {
        TaskCancel_0407()
    }
}


/*
 How to create and run a Task
 Creating a basic task in Swift looks as follows:

 //타스크를 만들고 동작 시키는 방법이다. 결과적으로 basicTask에 결과가 저장이 된다.
 let basicTask = Task {
     return "This is the result of the task"
 }
 
 
 As you can see, we’re keeping a reference to our basicTask which returns a string value. We can use the reference to read out the outcome value: --> 이것이 중요하다. 타스크가 수행이 즉시 되고 결과는 basicTask에 저장이 된다.
    결과를 읽기 위해서는 basicTask.value를 읽는다.

 let basicTask = Task {
     return "This is the result of the task"
 }
 print(await basicTask.value)
 // Prints: This is the result of the task
 */
