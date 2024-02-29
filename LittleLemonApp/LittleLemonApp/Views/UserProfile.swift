//
//  UserProfile.swift
//  LittleLemonApp
//
//  Created by mf on 29.02.24.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @Binding var isLoggedIn: Bool
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "";
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? "" ;
    let email = UserDefaults.standard.string(forKey: kEmail) ?? "";
    
    
    var body: some View {
        NavigationStack(){
            VStack(alignment: .leading){
                Text("Personal information")
                Image("profile-image-placeholder")
                    .resizable(resizingMode: .stretch)
                    .frame(width: 100, height: 100)
                Text(firstName)
                Text(lastName)
                Text(email)
                Button(action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    isLoggedIn=false
                    
                }, label: {
                    Text("Logout")
                }).padding(.init(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 10)
            }
            .padding(10)
        }
    }
}

