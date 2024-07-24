//
//  PasswordManagerApp.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//

import SwiftUI

@main
struct PasswordManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
