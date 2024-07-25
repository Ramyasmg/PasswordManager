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
    
    init() {
        if (EncryptionHelper.loadEncryptionKey() == nil) {
            let encryptionKey = EncryptionHelper.generateSymmetricKey()
            EncryptionHelper.saveEncryptionKey(key: encryptionKey)
        }
       
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(PasswordListViewModel())
        }
    }
}
