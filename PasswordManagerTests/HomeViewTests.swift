//
//  HomeViewTests.swift
//  PasswordManagerTests
//
//  Created by Ramya K on 26/07/24.
//


//import XCTest
//import SwiftUI
//import UIKit
//
//
//@testable import PasswordManager
//
//extension HomeView: Inspectable {} // Allow HomeView to be inspected
//
//final class HomeViewTests: XCTestCase {
//    
//    var viewModel: PasswordListViewModel!
//
//    override func setUp() {
//        super.setUp()
//        viewModel = PasswordListViewModel()
//        viewModel.passwordEntries = [
//            CDPasswordEntry(id: UUID(), accountType: "Email", username: "test@example.com", password: "secret")
//        ]
//    }
//
//    func testHomeViewDisplaysPasswordEntries() throws {
//        // Given
//        let homeView = HomeView()
//            .environmentObject(viewModel)
//
//        // When
//        let inspector = try homeView.inspect().find(text: "Email")
//
//        // Then
//        XCTAssertNotNil(inspector, "Password entry should be displayed in the HomeView.")
//    }
//    
//    func testAddButtonPresentation() throws {
//        // Given
//        let homeView = HomeView()
//            .environmentObject(viewModel)
//        
//        let view = homeView.inspect()
//        // When
//        try view.find(button: "plus").tap()
//        
//        // Then
//        let sheet = try view.find(viewWithId: "AddNewView")
//        XCTAssertTrue(sheet.isPresent(), "AddNewView sheet should be presented.")
//    }
//    
//    func testSelectEntryShowsDetails() throws {
//        // Given
//        let homeView = HomeView()
//            .environmentObject(viewModel)
//        
//        let view = homeView.inspect()
//        try view.find(text: "Email").tap()
//        
//        // When
//        let sheet = try view.find(viewWithId: "AccountDetailsView")
//        
//        // Then
//        XCTAssertTrue(sheet.isPresent(), "AccountDetailsView sheet should be presented when an entry is selected.")
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        super.tearDown()
//    }
//}
