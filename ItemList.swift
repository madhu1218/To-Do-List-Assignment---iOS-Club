//
//  ItemList.swift
//  ToDoListApp
//
//  Created by Madhumita Subbiah on 2/3/25.
//

import SwiftUI
import Combine

class ItemList: Identifiable, Equatable, Hashable, ObservableObject {
    static func == (lhs: ItemList, rhs: ItemList) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: UUID
    let name: String
    @Published var items: [Item]
    let createdAt: Date = .init()

    var isCompleted: Bool {
        items.allSatisfy(\.isCompleted)
    }

    init(name: String, items: [Item] = []) {
        self.id = UUID()
        self.name = name
        self.items = items
    }

    struct Item: Identifiable, Equatable {
        let id: UUID
        let title: String
        var isCompleted: Bool
        let createdAt: Date = .init()

        init(title: String, isCompleted: Bool = false) {
            self.id = UUID()
            self.title = title
            self.isCompleted = isCompleted
        }
    }

    func addItem(_ title: String) {
        let item = Item(title: title)
        items.append(item)
    }

    func toggleItemAsCompleted(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items[index].isCompleted.toggle()
        }
    }
}

