//
//  PasswordEntryView.swift
//  PasswordManager
//
//  Created by Ramya K on 26/07/24.
//

import SwiftUI


struct PasswordEntryRow: View {
    var entry: CDPasswordEntry
    @EnvironmentObject var viewModel: PasswordListViewModel
    
    var body: some View {
        Section {
            HStack {
                Text(entry.accountType)
                    .font(.headline)
                
                Text(String(repeating: "*", count: viewModel.getDecryptedText(text: entry.password)?.count ?? 5))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .listRowSeparator(.hidden)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 0.5)
            
        }
    }
    
}
