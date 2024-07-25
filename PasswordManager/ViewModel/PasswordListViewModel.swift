//
//  PasswordListViewModel.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//


import Foundation
import CoreData
import SwiftUI


class PasswordListViewModel: ObservableObject {
    
    @Published var passwordEntries: [CDPasswordEntry] = []
    
    private let persistenceController = PersistenceController.shared
    
    
    init() {
        fetchPasswordEntries()
    }
    
    
    public  func fetchPasswordEntries() {
        let fetchRequest: NSFetchRequest<CDPasswordEntry> = CDPasswordEntry.fetchRequest()
        
        do {
            self.passwordEntries = try persistenceController.viewContext.fetch(fetchRequest)
            
        } catch {
            print("Error fetching password entries: \(error)")
        }
    }
    
    
    func savePasswordEntry(accountType: String, username: String, password: String) {
        let newEntry = CDPasswordEntry(context: persistenceController.viewContext)
        newEntry.accountType = accountType
        newEntry.username = username
        newEntry.password = EncryptionHelper.encrypt(text: password) ?? ""
        
        persistenceController.save()
        
        passwordEntries.append(newEntry)
    }
    
    
    func updatePasswordEntry(entry: CDPasswordEntry, accountType: String, username: String, password: String) {
        entry.accountType = accountType
        entry.username = username
        entry.password = EncryptionHelper.encrypt(text: password) ?? ""
        if let index = passwordEntries.firstIndex(of: entry) {
            passwordEntries[index] = entry
        }
        persistenceController.save()
    }
    
    
    func deletePasswordEntry(entry: CDPasswordEntry) {
        persistenceController.viewContext.delete(entry)
        
        do {
            try persistenceController.viewContext.save()
            if let index = passwordEntries.firstIndex(of: entry) {
                passwordEntries.remove(at: index)
            }
        } catch {
            print("Error deleting entry: \(error)")
        }
    }
    
    
    func getDecryptedText(text: String) -> String? {
        return  EncryptionHelper.decrypt(encryptedText: text)
    }
    
}
