//
//  HappyTimeApp.swift
//  HappyTime
//
//  Created by samuelsong on 2022/6/2.
//

import SwiftUI

@main
struct HappyTimeApp: App {

    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            appDelegate.createTabView()
        }
    }
}
