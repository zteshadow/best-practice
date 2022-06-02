//
//  TabItem.swift
//  HappyTime
//
//  Created by samuelsong on 2022/6/2.
//

import Foundation
import SwiftUI

enum Tab: Int, Hashable {
    case club, book, food, profile
}

struct TabItem: Identifiable {
    var id: Tab
    var title: LocalizedStringKey
    var image: Image
}
