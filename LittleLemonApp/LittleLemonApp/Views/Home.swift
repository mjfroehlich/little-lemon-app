//
//  Home.swift
//  LittleLemonApp
//
//  Created by mf on 26.02.24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView { 
            Menu().tabItem { Label("Menu", systemImage: "list.dash") }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
