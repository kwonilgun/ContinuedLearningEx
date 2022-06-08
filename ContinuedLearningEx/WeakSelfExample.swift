//
//  WeakSelfExample.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/12.
//

import SwiftUI

struct WeakSelfExample: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination:
                WeakSelfSecondScreen())
                            .navigationTitle("Screen 1")
                    
            }
            .overlay(
                //여기서 count 값이 nil 이면 0을 리턴하고 그렇치 않으면
                //count 값을 리턴한다. 중위 연산자이다.
                Text("\(count ?? 0)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.green.cornerRadius(10))
                ,alignment: .topTrailing
            )
            
            
        }
}

/// weak signal에 대한 예제이다
struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}


//이것을 잘 파악을 해야 한다. @StateObject var vm = WeakSelfSecondViewModel() 선언을 하면
// data가 reactive하게 동작을 한다. data가 초기에는 nil이지만, DispatchQueue.main.asyncAfter(deadline: .now() + 5)  5초 뒤에 클로저가 실행이 되면 화면에 "New Data" 가 나타나게 된다. 이것이 나타나기 전에 Back 키로 취소를 하면 [weak self]로 인해서 자동으로 메모리 해제가 되고 deinit()가 호출이 된다. 
class WeakSelfSecondViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("Initialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    //deinit는 두번째가 화면이 시작이 되면 첫번째 화면을 deinit 한다.
    //이것은 메모리를 해제하는 것과 같은 방식이 된다. 이렇게해야 메모리를
    //효율적으로 관리를 할 수 있다. 이것이 동작 메커니즘이다.
    deinit {
        print("Deinitize")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
//        DispatchQueue.global().async {
//            self.data = "New Data!!!" //이것은 strong 참조이다. 이것은 메모리 leak 현상을 발생할 수 있다.
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
//            self.data = "New Data!!!"
//        }
        
        /*
           500초 뒤에 self?.data 가 실행이 된다. 하지만 weak 참조이기 때문에
           빠져 나오면 메모리에서 지워지게 된다. 즉 화면을 빠져 나오면 바로 Deinit가 실행이 된다.
           그럼으로써 메모리 leak 현상이 없어지게 된다 특히 async task에 이것을 사용하면
           실행화면을 나오게 되면 같이 deinit를 하게 된다!!!!!!!
           
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.data = "New Data!!!"
            }
        
    }
}
struct WeakSelfExample_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfExample()
    }
}
