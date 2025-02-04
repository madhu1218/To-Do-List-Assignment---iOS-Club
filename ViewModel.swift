//
//  ViewModel.swift
//  ToDoListApp
//
//  Created by Madhumita Subbiah on 2/3/25.
//

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var lists: [ItemList] = [
        ItemList(name: "List 1"),
        ItemList(name: "List 2"),
    ]
    
    init() {}
    
    func createList(name: String) {
        let list = ItemList(name: name)
        lists.append(list)
    }
    
    func addItem(to list: ItemList, name: String) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index].items.append(ItemList.Item(title: name))
        }
    }
    
    func toggleItemAsCompleted(_ item: ItemList.Item, list: ItemList) {
        if let listIndex = lists.firstIndex(where: { $0.id == list.id }),
           let itemIndex = lists[listIndex].items.firstIndex(of: item) {
            lists[listIndex].items[itemIndex].isCompleted.toggle()
        }
    }
    
    func deleteList(at indexSet: IndexSet) {
        lists.remove(atOffsets: indexSet)
    }
    
    func deleteItem(from list: ItemList, at indexSet: IndexSet) {
        if let listIndex = lists.firstIndex(where: { $0.id == list.id }) {
            lists[listIndex].items.remove(atOffsets: indexSet)
        }
    }
}
