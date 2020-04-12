//
//  OC2Swift.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/12.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation

//十几个小知识点，让你理解OC到Swift的都有哪些转变
//https://juejin.im/post/5e8485d16fb9a03c3d7378a6

class Class1 {
    //    @objc func callMehtod()  {
        
    //}

    @objc func callMethod(parm: Int){
        
    }

    let sel = #selector(callMethod)
}

struct Struct1 {
    
}


func testOC2Swift(){
    
    //打印值类型变量的内存地址
    var s = Struct1()
    withUnsafePointer(to: &s) { o in
        print(o)
    }
    print(UnsafeRawPointer(&s))
    
    //打印引用类型变量指向的内存地址
    let c = Class1()
    print(Unmanaged.passUnretained(c).toOpaque())
}
