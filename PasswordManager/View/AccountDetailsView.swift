//
//  AccountDetailsView.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//

import SwiftUI

struct AccountDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: PasswordListViewModel
    
    var entry: CDPasswordEntry
    
    @State private var accountType = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isFormValid: Bool = true
    @State private var errorMessage: String = ""
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Account Details")
                .foregroundColor(.blue)
                .font(Font.system(size: 16, weight: .medium))
                .padding(.bottom, 10)
            
            DetailField(title: "Account Type", value: $accountType)
            if !isFormValid && accountType.isEmpty {
                Text("Account Type is required.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            DetailField(title: "Username/Email", value: $username)
            if !isFormValid && username.isEmpty {
                Text("Username/Email is required.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Text("Password")
                .foregroundColor(.gray)
                .font(.system(size: 11))
            SecureTextField(isSecureField: true, text: $password)
                .font(.system(size: 14))
            if !isFormValid && password.isEmpty {
                Text("Password is required.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                ActionButton(title: "Edit", backgroundColor: .black) {
                    updateData()
                }
                
                ActionButton(title: "Delete", backgroundColor: .red) {
                    deleteData()
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            loadInitialValues()
        }
        
    }
    
    
    func loadInitialValues() {
        accountType = entry.accountType
        username = entry.username
        password = viewModel.getDecryptedText(text: entry.password) ?? ""
    }
    
    
    func updateData() {
        if accountType.isEmpty || username.isEmpty || password.isEmpty {
            isFormValid = false
            errorMessage = "All fields are mandatory."
        }
        else {
            isFormValid = true
            errorMessage = ""
            viewModel.updatePasswordEntry(entry: entry, accountType: accountType, username: username, password: password)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    func deleteData() {
        viewModel.deletePasswordEntry(entry: entry)
        presentationMode.wrappedValue.dismiss()
    }
    
}


struct DetailField: View {
    var title: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(.gray)
                .font(.system(size: 11))
            TextField(title, text: $value)
                .font(.system(size: 14))
                .padding(.bottom, 10)
        }
    }
}


struct ActionButton: View {
    var title: String
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 45)
                .background(backgroundColor)
                .cornerRadius(25)
        }
    }
}
