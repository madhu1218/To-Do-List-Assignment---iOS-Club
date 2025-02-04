//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Madhumita Subbiah on 2/3/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showAddList = false
    @State private var newListName = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.lists) { list in
                    NavigationLink(list.name, value: list)
                }
                .onDelete { indexSet in
                    viewModel.deleteList(at: indexSet)
                }
            }
            .navigationDestination(for: ItemList.self) {
                ItemListView(list: $0)
            }
            .navigationTitle("Lists")
            .toolbar {
                Button(action: { showAddList.toggle() }) {
                    Image(systemName: "plus")
                }
            }
        }
        .alert("New List", isPresented: $showAddList) {
            TextField("List Name", text: $newListName)
            Button("Cancel", role: .cancel) { newListName = "" }
            Button("Done") {
                if !newListName.isEmpty {
                    viewModel.createList(name: newListName)
                    newListName = ""
                }
            }
        } message: {
            Text("What is the name of the new list?")
        }
    }
}
