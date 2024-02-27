//
//  Home.swift
//  LittleLemonApp
//
//  Created by mf on 26.02.24.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView { 
            Menu()
                .tabItem { Label("Menu", systemImage: "list.dash") }
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
