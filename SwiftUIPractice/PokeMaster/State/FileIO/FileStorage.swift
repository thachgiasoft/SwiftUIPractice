//
//  FileStorage.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/21.
//  Copyright © 2020 lizhu. All rights reserved.
//

import Foundation

@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    let directory:FileManager.SearchPathDirectory
    let fileName:String
    
    var wrappedValue: T? {
        get {value}
        
        set {
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            }else{
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
    }
}
