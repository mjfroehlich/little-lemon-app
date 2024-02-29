//
//  Home.swift
//  LittleLemonApp
//
//  Created by mf on 26.02.24.
//

import SwiftUI

struct Home: View {
    @Binding var isLoggedIn: Bool
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView { 
            Menu()
                .tabItem { Label("Menu", systemImage: "list.dash") }
                .environment(\.managedObjectContext, persistence.container.viewContext)
            UserProfile(isLoggedIn: $isLoggedIn)
                .tag(1)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

