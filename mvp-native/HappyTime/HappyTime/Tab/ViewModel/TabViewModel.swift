//
//  TabViewModel.swift
//  HappyTime
//
//  Created by samuelsong on 2022/6/2.
//

import SwiftUI

final class TabViewModel: ObservableObject {
    @Published var tabList: [TabItem]
    var selected: Tab = .club

    init() {
        tabList = [
            .init(id: .club, title: "Club", image: Image(systemName: "gamecontroller")),
            .init(id: .book, title: "Book", image: Image(systemName: "books.vertical")),
            .init(id: .food, title: "Food", image: Image(systemName: "fork.knife.circle")),
            .init(id: .profile, title: "Profile", image: Image(systemName: "person")),
                  ]
    }

    @ViewBuilder
    func tabView(_ tab: TabItem) -> some View {
        switch(tab.id) {
        case .club:
            clubView
        case .book:
            bookView
        case .food:
            foodView
        case .profile:
            profileView
        }
    }

    lazy var clubView: some View = {
        NavigationView {
            Text("Club").navigationTitle("Club")
        }
    }()

    lazy var bookView: some View = {
        NavigationView {
            Text("Book").navigationTitle("Book")
        }
    }()

    lazy var foodView: some View = {
        NavigationView {
            Text("Club").navigationTitle("Club")
        }
    }()

    lazy var profileView: some View = {
        NavigationView {
            Text("Profile").navigationTitle("Profile")
        }
    }()
}
