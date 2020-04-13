//
//  SwiftUIPracticeTests.swift
//  SwiftUIPracticeTests
//
//  Created by lizhu on 2020/4/11.
//  Copyright © 2020 lizhu. All rights reserved.
//

import XCTest
@testable import SwiftUIPractice

struct Student {
    let name: String
    let scores: [Subject:Int]
    
}

enum Subject {
    case chinees,math,english,physical
}

class SwiftUIPracticeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let s1 = Student(name: "Jane", scores: [.chinees:86,.math:92,.english:73,.physical:88])
        let s2 = Student(name: "Tome", scores: [.chinees:99,.math:52,.english:97,.physical:36])
        let s3 = Student(name: "Emma", scores: [.chinees:91,.math:92,.english:100,.physical:99])
        
        let students = [s1,s2,s3]
        
        //检查students里的学生平均分并输出第一名的姓名
        func average(_ scores: [Subject:Int]) ->Double{
            Double(scores.values.reduce(0, +)/scores.count)
        }
        
        let bestStudent = students
                            .map { ($0,average($0.scores)) }
                            .sorted { $0.1>$1.1 }
                            .first
        print(bestStudent!)
        
        //计算所有学生的语文成绩平均分，并将其打印出来
        print(students.reduce(0) { $0 + ($1.scores[.chinees] ?? 0) }/students.count)
        
        //统计各个科目的及格率（>60），并将及格率结果进行排序
//        students.reduce(students.first?.scores.first!) { (accumulater, student) -> [Subject:Double] in
//
//            var temp_ac = accumulater
//            student.scores.keys.forEach { (subject) in
//                if student.scores[subject] ?? 0 > 60 {
//                    if var temp_sub = accumulater[subject] {
//                        temp_sub += 1.0
//                        temp_ac.updateValue(temp_sub, forKey: subject)
//                    } else {
//                        temp_ac.updateValue(1.0, forKey: subject)
//                    }
//                }
//            }
//            return temp_ac
//        }.map({ ($0, $1 / Double(students.count)) }).sorted(by: { return $0.1 > $1.1 })
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
