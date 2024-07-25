//
//  HomeView.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: PasswordListViewModel
    
    @State private var selectedEntry: CDPasswordEntry? = nil
    @State private var isShowingDetails = false
    @State private var isAddingNew = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {

                List(viewModel.passwordEntries, id: \.id) { entry in
                    
                    PasswordEntryRow(entry: entry)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedEntry = entry
                            isShowingDetails = true
                        }
                }
                .listStyle(PlainListStyle())
                addButton
                    .padding(25)
            }
            
            
            .sheet(item: $selectedEntry) { entry in
                AccountDetailsView(entry: entry)
                    .environmentObject(viewModel)
                    .presentationDetents([.fraction(0.5)])
            }
        
            
            .sheet(isPresented: $isAddingNew) {
                AddNewView(isPresented: $isAddingNew)
                    .presentationDetents([.medium])
            }
            
            .navigationTitle("Password Manager")
            .onAppear {
                viewModel.fetchPasswordEntries()
            }
            
        }
        
    }
    
    
    private var addButton: some View {
        Button(action: {
            isAddingNew = true
        }) {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PasswordListViewModel())
    }
}
