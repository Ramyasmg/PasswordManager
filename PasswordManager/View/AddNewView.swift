//
//  AddNewView.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//


import SwiftUI

struct AddNewView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject var viewModel: PasswordListViewModel
    
    @State private var accountType = ""
    @State private var username = ""
    @State private var password = ""
    @State private var isFormValid: Bool = true
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            // Account Type Input
            TextField("Account Name", text: $accountType)
                .padding()
                .background(Color.gray.opacity(0.1))
            if !isFormValid && accountType.isEmpty {
                Text("Account Type is required.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            // Username input
            TextField("Username/Email", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
            if !isFormValid && username.isEmpty {
                Text("Username/Email is required.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            
            //Password Input
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
            if !isFormValid && password.isEmpty {
                Text("Password is required.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            
            Button("Add New Account") {
                saveAccount()
            }
            .frame(maxWidth: .infinity, maxHeight: 15)
            .foregroundColor(.white)
            .padding()
            .background(Color.black)
            .cornerRadius(40)
            .padding()
        }
        .listRowSeparator(.hidden)
        .listStyle(.plain)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 0.1)
    }
    
    
    private func saveAccount() {
        if accountType.isEmpty || username.isEmpty || password.isEmpty {
            isFormValid = false
            errorMessage = "All fields are mandatory."
        } else {
            isFormValid = true
            errorMessage = ""
            viewModel.savePasswordEntry(accountType: accountType, username: username, password: password)
            isPresented = false
        }
    }
    
}


struct AddNewView_Previews: PreviewProvider {
    static var previews: some View {
        let isPresented = Binding.constant(true)
        AddNewView(isPresented: isPresented).environmentObject(PasswordListViewModel())
    }
}
