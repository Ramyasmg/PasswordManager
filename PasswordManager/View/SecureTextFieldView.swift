//
//  SecureTextFieldView.swift
//  PasswordManager
//
//  Created by Ramya K on 25/07/24.
//

import SwiftUI

struct SecureTextField: View {
    
    @State var isSecureField: Bool = true
    @Binding var text: String
    
    
    var asteriskText: String {
        return String(repeating: "*", count: text.count)
    }
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField(asteriskText, text: $text)
                
            } else {
                TextField(asteriskText, text: $text)
            }
            
        }
        .overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash" : "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
    
}
