//
//  Redux.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/3.
//

import Foundation

protocol ActionType {}
protocol StateType {}
protocol CommandType {}

struct State: StateType {
    var todos: [String] = [] {
        didSet {
            title = "TODO - (\(todos.count))"
        }
    }
    var title = ""
    var text = ""
}

enum Action: ActionType {
    case load
    case remove(index: Int)
    case add
    case addItems(items: [String])
    case updateText(text: String)
}

enum Command: CommandType {
    case load
}

struct Redux {
    static let reducer: (State, Action) -> (State, Command?) = { state, action in
        var cmd: Command? = nil
        var state = state
        switch action {
        case .load:
            cmd = .load
        case .remove(let index):
            state.todos.remove(at: index)
        case .add:
            var list = state.todos
            list.append(state.text)
            state.todos = list
        case .addItems(let items):
            state.todos = items + state.todos
        case .updateText(let text):
            state.text = text
        }

        return (state, cmd)
    }
}
