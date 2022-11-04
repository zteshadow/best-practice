//
//  Presenter.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/2.
//

import Foundation

protocol ToDoListView: AnyObject {
    func update(list: [String], title: String)
    func enableAdd(_ enable: Bool)
}

protocol ToDoListPresenter {
    func load()
    func remove(at index: Int)
    func edit(_ text: String)
    func add()
}

class ToDoListPresenterImpl: ToDoListPresenter {
    unowned var view: ToDoListView

    var todos: [String] = [] {
        didSet {
            view.update(list: todos, title: "TODO - (\(self.todos.count))")
        }
    }
    var text = "" {
        didSet {
            view.enableAdd(text.count >= 3)
        }
    }

    init(_ view: ToDoListView) {
        self.view = view
    }

    func load() {
        view.enableAdd(false)

        ToDoStore.shared.getToDoItems { [weak self] (data) in
            guard let self = self else {
                return
            }
            self.todos += data
        }
    }

    func remove(at index: Int) {
        guard index >= 0 && index < todos.count else {
            return
        }

        todos.remove(at: index)
    }

    func edit(_ text: String) {
        self.text = text
    }

    func add() {
        guard text.count >= 3 else {
            return
        }

        todos.insert(text, at: 0)
        text = ""
    }
}
