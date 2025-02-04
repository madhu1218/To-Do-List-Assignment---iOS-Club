//
//  ItemListView.swift
//  ToDoListApp
//
//  Created by Madhumita Subbiah on 2/3/25.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var viewModel: ViewModel
    @ObservedObject var list: ItemList
    
    @State private var showingAddItem = false
    @State private var newItemText = ""

    var body: some View {
        List {
            ForEach(list.items) { item in
                HStack {
                    Button(action: {
                        withAnimation {
                            viewModel.toggleItemAsCompleted(item, list: list)
                        }
                    }) {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .imageScale(.large)
                            .foregroundColor(item.isCompleted ? .green : .accentColor)
                            .animation(.easeInOut, value: item.isCompleted)
                    }
                    
                    Text(item.title)
                        .strikethrough(item.isCompleted, color: .gray)
                }
            }
            .onDelete { indexSet in
                viewModel.deleteItem(from: list, at: indexSet)
            }
        }
        .navigationTitle(list.name)
        .toolbar {
            Button(action: { showingAddItem.toggle() }) {
                Image(systemName: "plus")
            }
        }
        .alert("Add Item", isPresented: $showingAddItem) {
            TextField("Item Title", text: $newItemText)
            Button("Cancel", role: .cancel) { newItemText = "" }
            Button("Add") {
                viewModel.addItem(to: list, name: newItemText)
                newItemText = ""
            }
            .disabled(newItemText.isEmpty)
        } message: {
            Text("Add item to " + list.name)
        }
    }
}
