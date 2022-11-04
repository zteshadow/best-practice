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

    func testRemove() throws {
        let view = MockView()
        let presenter = ToDoListPresenterImpl(view)

        view.updateHandler = { _, _ in
            XCTFail()
        }

        presenter.remove(at: 0)

        presenter.todos = ["1", "2"]
        view.updateHandler = { list, title in
            XCTAssertEqual(list, ["2"])
            XCTAssertEqual(title, "TODO - (1)")
        }
        presenter.remove(at: 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockView: ToDoListView {

    var updateHandler: ([String], String) -> Void = { _, _ in }
    var enableHandler: (Bool) -> Void = { _ in }
    var clearHandler: () -> Void = {}

    func update(list: [String], title: String) {
        updateHandler(list, title)
    }

    func enableAdd(_ enable: Bool) {
        enableHandler(enable)
    }

    func clearInput() {
        clearHandler()
    }
}
