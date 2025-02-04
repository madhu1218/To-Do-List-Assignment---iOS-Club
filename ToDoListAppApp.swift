//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Madhumita Subbiah on 2/3/25.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @StateObject private var viewModel = ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
