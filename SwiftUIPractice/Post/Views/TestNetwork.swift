//
//  TestNetwork.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/22.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

struct TestNetwork: View {
    var body: some View {
        Button(action: {
            //safari 右键raw复制链接
            //chrome 双击右键raw复制链接
            let url = URL(string: "https://httpbin.org/get")!
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    return
                }
                guard let list = try? JSONDecoder().decode(PostList.self, from: data) else{
                    return
                }
                print(list.list.count)
            }
            task.resume()
        }) {
            Text("连接网络")
        }
        
    }
}

struct TestNetwork_Previews: PreviewProvider {
    static var previews: some View {
        TestNetwork()
    }
}
