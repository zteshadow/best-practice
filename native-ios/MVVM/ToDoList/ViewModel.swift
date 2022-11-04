//
//  Presenter.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/2.
//

import Combine
import Foundation

class ToDoListViewModel {
    @Published var todos: [String] = [] {
        didSet {
            title = "TODO - (\(self.todos.count))"
        }
    }
    @Published var title: String = ""
    @Published var enableAdd: Bool = false

    var text = "" {
        didSet {
            if text.count > 3 {
                enableAdd = true
            } else {
                enableAdd = false
            }
        }
    }

    func load() {
        enableAdd = false

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

    func add() {
        guard text.count > 3 else {
            return
        }

        todos.insert(text, at: 0)
        enableAdd = false
    }
}
