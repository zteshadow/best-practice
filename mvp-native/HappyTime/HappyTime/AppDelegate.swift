//
//  AppDelegate.swift
//  HappyTime
//
//  Created by samuelsong on 2022/6/2.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    private let rootViewModel: TabViewModel

    override init() {
        rootViewModel = TabViewModel()
    }

    func createTabView() -> some View {
        return RootView(viewModel: rootViewModel)
    }
}
