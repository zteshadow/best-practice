//
//  RootView.swift
//  HappyTime
//
//  Created by samuelsong on 2022/6/2.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: TabViewModel

    var body: some View {
        TabView(selection: $viewModel.selected) {
            ForEach (viewModel.tabList) { item in
                viewModel.tabView(item)
                    .tabItem {
                        item.image
                        Text(item.title)
                    }
            }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: TabViewModel())
    }
}
