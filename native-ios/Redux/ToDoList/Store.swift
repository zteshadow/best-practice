//
//  Store.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/3.
//

import Foundation

class Store<S, A, C> {
    private var state: S
    private var reducer: (S, A) -> (S, C?)
    private var subscriber: ((S?, S, C?) -> Void)?

    init(initialState: S, reducer: @escaping (S, A) -> (S, C?)) {
        self.state = initialState
        self.reducer = reducer
    }

    func dispatch(action: A) {
        let originalState = state
        let (newState, cmd) = reducer(originalState, action)
        state = newState
        subscriber?(originalState, newState, cmd)
    }

    func subscribe(_ callback: @escaping (S?, S, C?) -> Void) {
        self.subscriber = callback
    }

    func unSubscribe() {
        self.subscriber = nil
    }
}
