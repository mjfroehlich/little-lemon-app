//
//  Menu.swift
//  LittleLemonApp
//
//  Created by mf on 26.02.24.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Little Lemon")
                .foregroundColor(Color.primaryColor2)
                .font(.displayFont())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Chicago")
                .foregroundColor(.white)
                .font(.subTitleFont())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("""
             We are a family owned Mediterranean restaurant, just the best for our customers.
             """)
            .foregroundColor(.white)
            .font(.leadText())
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.primaryColor1)
        .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
