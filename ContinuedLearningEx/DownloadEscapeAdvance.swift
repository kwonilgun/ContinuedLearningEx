//
//  DownloadEscapeAdvance.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/12.
//


//여기서 알아야 할 것
//1. Codable 프로토콜
//2. weak self
//3. backgroud threads
//4. escaping closure

import SwiftUI

struct PostModelAd: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


/*
//DispatchQueue.main.async:
작업을 수행하자마자 현재의 queue에 컨트롤을 넘겨주고 작업이 끝나기 전까지 기다릴 필요가 없습니다.데이터를 로드하거나 특정 무거운 작업을 실행하게 될 때 어플리케이션의 UI는 느려지거나 멈추게 됩니다.  DispatchQueue.main.async는 클로저 안의 실행문을 작업을 대기열로 보내 비동기로 작업을 실행하여 동시에 2가지 이상의 task를 수행할 수 있도록 도와줍니다. 하지만 스레드에 안전하지 않기 때문에 서로 다른 스레드에서 동일한 변수를 변경, 사용하게 된다면 문제가 되니 주의해야 합니다!

                
    -결과적으로 보면 main에 하기의 클로저의 코드를 보내고
    URLSession.shared.dataTask(..).resume()에 의해서 쓰레드가 실행이 되고 메인 큐에 클로저를 던지고 바로 빠져 나온다. 빠져 나오면서 메인 타스크 즉 UI를 처리하는 타스크에서 이 값을 받아서 처리를 하게 되는 것이다.
 
 - 프로그램 실행 순서
 1.DownloadwithEscapingViewModelAd()
 2. init() { getPost() } -> getPost 함수 실행
 3. downloadData() 함수에 탈출 클로저를 전달한다.
 4.  URLSession.shared.dataTask(with: url) { }.resume()이 타스크를 실행한다. 다른 쓰레드가 작동한다.
        data, response, error : 클라우드에서 받아온다.
 5.  completionHander(data)가 실행이 된다.
 6. escaping closure에 안에 있는 DispatchQueue.main.async {[weak self] in self?.postsAd = newPostAd} 가 실행된다. 이 실행 코드를 main task, 즉 UI를 처리하는 타스크의 큐로 전달한다.
 7. 바로 URLSession 타스크가 완료되고
 8. var body: some View {
        List {
                ....
        }
    }. 가 실행이 된다. 
 */

class DownloadwithEscapingViewModelAd: ObservableObject {
    
    //@Published var postsAd: [PostModelAd] = []
    @Published var postsAd: [PostModelAd]? = nil
    @Published var flag: Bool = false
    
    init() {
        getPost()
    }
    
    deinit {
        print("Deinitialized 됨. ")
    }
    
    func getPost() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) {
            
            //이부분이 completionHandler에 해당이 된다.
            returnedData in
            
            if let data = returnedData {
                
                guard let newPostAd = try? JSONDecoder().decode([PostModelAd].self, from: data) else { return }
                
                print([PostModelAd].self)
                print(self)


                //DispatchQueue.main.async {
                
                //2022-6월-3일: 이것은 10초 뒤에 클로저가 실행이 된다. 이것은 async 타스크로 기다리지 않고 큐에 요청을 한다. 10초 뒤에 메인에서 실행이 된다.
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    //이것을 약한 참조이고 메모리 leak을 방지할 수 있다. 기다리는 동안 화면을 빠져나오면
                    //같이 deinit를 하게 된다.
                    [weak self] in self?.postsAd = newPostAd
                }
                
                
            } else {
                print("No data returned")
            }
        }
        
    }
    
    func downloadData(fromURL url: URL, completionHander: @escaping(_ data:Data?) -> ()) {
        
        
        //Task를 실행한다. 다른 쓰레드에서 실행이 된다. 이것이 실행이 되고 난 후에 completionHandler가 작동이 되고 여기서 데이터를 담고
        //func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
        
        URLSession.shared.dataTask(with: url) {
            
            //이 부분이 또한 @escaping 크로저에 해당이 된다.
            //여기서 data는 서버에 의해서 리턴된 것이다.
            
            data, response, error in
            
            // data: 가져온 데이터의 body
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                    print("Error Downloading")
                    completionHander(nil)
                    return
            }
            completionHander(data)
           
        }.resume()
        
    }
}

struct DownloadEscapeAdvance: View {
    
    @StateObject var vm = DownloadwithEscapingViewModelAd()
    
    var body: some View {
        VStack {
            //if vm.postsAd!.isEmpty {
            Button {
                print("취소 버튼을 누름")
                //vm.flag = true
                vm.postsAd = nil
                
            } label: {
                Text(" 취소 버튼")
            }
            
            Button {
                print("재 실행 누름")
                vm.getPost()
            } label: {
                Text(" 재 실행 버튼")
            }
            
            //}
            //else {
            // if(vm.flag == true) {
            List {
                if let data = vm.postsAd {
                    ForEach( data ) { post in
                        VStack(alignment: .leading, spacing: 10){
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .foregroundColor(.gray)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            //}
            //}
        }
    }
}

struct DownloadEscapeAdvance_Previews: PreviewProvider {
    static var previews: some View {
        DownloadEscapeAdvance()
    }
}
