//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by samuelsong on 2022/11/2.
//

import XCTest
@testable import ToDoList

class ToDoListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNormal() throws {
        let viewModel = ToDoListViewModel()

        viewModel.todos = ["1"]
        XCTAssertEqual(viewModel.title, "TODO - (1)")
    }

    func testAdd() {
        let viewModel = ToDoListViewModel()
        viewModel.text = "1234"
        viewModel.add()
        XCTAssertEqual(viewModel.todos, ["1234"])
        XCTAssertEqual(viewModel.title, "TODO - (1)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

