//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by samuelsong on 2022/11/2.
//

import Combine
import XCTest
@testable import ToDoList

class ToDoListTests: XCTestCase {

    var bags = Set<AnyCancellable>()

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

    func testRemove() {
        let viewModel = ToDoListViewModel()

        viewModel.remove(at: 0)

        viewModel.todos = ["1", "2"]
        viewModel.remove(at: 0)

        XCTAssertEqual(viewModel.todos, ["2"])
        XCTAssertEqual(viewModel.title, "TODO - (1)")
    }

    func testLoad() {
        let viewModel = ToDoListViewModel()

        let waitForLoad = super.expectation(description: "wait for load")
        viewModel.load()

        viewModel.$todos.dropFirst().sink { list in
            XCTAssertEqual(list, dummy)
            waitForLoad.fulfill()
        }.store(in: &bags)

        wait(for: [waitForLoad], timeout: 2)
    }

}

