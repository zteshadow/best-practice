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

        view.updateHandler = { list, title in
            XCTAssertEqual(list, ["1", "2"])
            XCTAssertEqual(title, "TODO - (2)")
        }
        presenter.todos = ["1", "2"]

        view.updateHandler = { list, title in
            XCTAssertEqual(list, ["2"])
            XCTAssertEqual(title, "TODO - (1)")
        }
        presenter.remove(at: 0)
    }

    func testEdit() {
        let view = MockView()
        let presenter = ToDoListPresenterImpl(view)

        view.enableHandler = { enabled in
            XCTAssertFalse(enabled)
        }
        presenter.edit("he")

        view.enableHandler = { enabled in
            XCTAssertTrue(enabled)
        }
        presenter.edit("hel")
    }

    func testAdd() {
        let view = MockView()
        let presenter = ToDoListPresenterImpl(view)

        view.updateHandler = { _, _ in
            XCTFail()
        }
        presenter.edit("he")
        presenter.add()

        presenter.edit("hello")
        view.updateHandler = { list, title in
            XCTAssertEqual(list, ["hello"])
            XCTAssertEqual(title, "TODO - (1)")
        }
        view.enableHandler = { enabled in
            XCTAssertFalse(enabled)
        }
        presenter.add()
    }

    func testLoad() {
        let view = MockView()
        let presenter = ToDoListPresenterImpl(view)

        let expectation = super.expectation(description: "wait for load")
        view.enableHandler = { enabled in
            XCTAssertFalse(enabled)
        }

        view.updateHandler = { list, title in
            XCTAssertEqual(list, [
                "Buy the milk",
                "Take my dog",
                "Rent a car"
            ])
            XCTAssertEqual(title, "TODO - (3)")
            expectation.fulfill()
        }
        presenter.load()
        wait(for: [expectation], timeout: 2)
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
