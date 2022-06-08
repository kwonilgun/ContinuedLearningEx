//
//  DownloadEscapeBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/10.
//

import SwiftUI

/*
 Codable

 Codable이란 Decodable과 Encodable 이 합쳐진 것으로 Swift 4 버전부터 이용 가능한 프로토콜입니다.
 구조체(structure)에 이것을 추가하면 외부 표현(대표적으로 JSON)으로 인코딩 또는 디코딩이 가능하게 됩니다.
 Codable을 구현한 struct를 만들 때 구조체 내부의 변수 이름과 JSON의 변수 이름과 동일하게 맞추는 것이 중요합니다.
 만약 불가피하게 다르게 해야 할 경우 CodingKey라는 enum을 생성하여 서로의 변수 이름을 매핑합니다.
 */
struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadwithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        //shared 는 싱글 톤이다. 
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // data: 가져온 데이터의 body
            guard let data = data else {
                print("No data.")
                return
            }
            
            //error: 가져오기 실패했을 경우 에러 정보를 가져 옵니다.
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }

            //response: 헤더 정보등 리퀘스트와 관련된 정보
            //response를 HTTPURLResponse로 다운 캐스팅을 한다. 이렇게 처리를 하고 값이 있으면
            // 그다음 처리를 하게 된다.
            guard let response = response as? HTTPURLResponse  else {
                print("Invalid response")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be ...")
                return
            }
            
//            print("Successfully download data")
//            print(data)
            
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString)
            
            //data로부터 받아온 자료를 PostModel 타입으로 디코딩을 한다.
            
            //try?
            //에러 발생 시 nil 반환합니다.
            //에러가 발생하지 않으면 반환 타입은 옵셔널(Optional)입니다.
            //반환 타입이 없어도 사용 가능합니다.
            //do-catch문 없이 사용가능합니다.
            //if let data = try? getData() {
            //  return data
            //}
            //PostModel.self 는 PostModel 의 메타 타입으로 보면된다. 메타 타입의 경우는 스택티 프로퍼티에
            //접근을 할 수 있다.
            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
            
            
            
            print("데이타 획득: =\(newPost)")
            
            //여기서 self는 DownloadwithEscapingViewModel 의 인스턴스이다.
            
            DispatchQueue.main.async {
                [weak self] in self?.posts.append(newPost)
            }
            
            //self.posts.append(newPost)
            
            
        }
        
        task.resume() //실제 테이터를 가져오기 위한 작업을 실행한다.
    }
}

struct DownloadEscapeBoot: View {
    
    //DownloadwithEsacpingViewModel()을 인스턴스 하면, 초기화를 할 것이다. 초기화에서 getPost()를 한다. 이렇게 하면 해당 사이트에서 Json 데이타를 가져온다. 이 데이터들은 vm.posts에 저장이 될 것이다. post 에 저장이 되면 자동으로 ForEach 에서  데이타를 읽엇 화면에 하나씩 보여주는 것이다. 
    
    @StateObject var vm = DownloadwithEscapingViewModel()
    
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
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
}

struct DownloadEscapeBoot_Previews: PreviewProvider {
    static var previews: some View {
        DownloadEscapeBoot()
    }
}
