//
//  EncryptionHelper.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//

import CryptoKit
import Foundation
import Security

class EncryptionHelper {
    
    private static let keychainKey = "com.passwordManager.encryptionKey"
    
    
    static func generateSymmetricKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }
    
    
    static func saveEncryptionKey(key: SymmetricKey) {
        let keyData = key.withUnsafeBytes { Data(Array($0)) }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecValueData as String: keyData
        ]

        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Error saving encryption key to Keychain")
            return
        }
    }
    
    
    static func loadEncryptionKey() -> SymmetricKey? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data else {
            print("Error retrieving encryption key from Keychain")
            return nil
        }
        
        return SymmetricKey(data: data)
    }
    
    
    // Encrypt text using AES-GCM with the loaded encryption key
    static func encrypt(text: String) -> String? {
        guard let encryptionKey = loadEncryptionKey() else {
            print("Encryption key not found")
            return nil
        }
        
        guard let textData = text.data(using: .utf8) else {
            print("Error converting text to data")
            return nil
        }
        
        do {
            let sealedBox = try AES.GCM.seal(textData, using: encryptionKey)
            let encryptedData = sealedBox.combined
            return encryptedData?.base64EncodedString()
        } catch {
            print("Encryption error: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    static func decrypt(encryptedText: String) -> String? {
        guard let encryptionKey = loadEncryptionKey() else {
            print("Encryption key not found")
            return nil
        }
        
        guard let encryptedData = Data(base64Encoded: encryptedText) else {
            print("Error decoding base64 encoded text")
            return nil
        }
        
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: encryptionKey)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error)")
            return nil
        }
    }
    
}
