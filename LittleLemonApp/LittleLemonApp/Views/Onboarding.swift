//
//  OnboardingView.swift
//  LittleLemonApp
//
//  Created by mf on 26.02.24.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "e-mail key"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isKeyboardVisible = false
    @State var contentOffset: CGSize = .zero
    
    @State var errorMessageShow = false
    @State var errorMessage = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("Logo")
                    .padding(.bottom)
                VStack(spacing: 0) {
                    Text("Little Lemon")
                        .foregroundColor(Color.primaryColor2)
                        .font(.displayFont())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        VStack {
                            Text("Chicago")
                                .foregroundColor(.white)
                                .font(.subTitleFont())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("""
                             We are a family owned Mediterranean restaurant, just the best for our guests!
                            """)
                            .foregroundColor(.white)
                            .font(.leadText())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        Image("HeroImage")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(maxWidth: 120, maxHeight: 140)
                            .clipShape(Rectangle())
                            .cornerRadius(16)
                    }
                }
                .padding()
                .background(Color.primaryColor1)
                .frame(maxWidth: .infinity, maxHeight: 200)
            }

                VStack {
                    Text("First name *")
                        .onboardingTextStyle()
                    TextField("First Name", text: $firstName)
                    Text("Last name *")
                        .onboardingTextStyle()
                    TextField("Last Name", text: $lastName)
                    Text("E-mail *")
                        .onboardingTextStyle()
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                
                if errorMessageShow {
                    withAnimation() {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
                
                Button("Register") {
                    if validateUserInput(firstName: firstName, lastName: lastName, email: email) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                    }
                }
                .buttonStyle(LittleLemonButtonStyle())
                
                Spacer()
            }
            .offset(y: contentOffset.height)
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                withAnimation {
                    let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let keyboardHeight = keyboardRect.height
                    self.isKeyboardVisible = true
                    self.contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                withAnimation {
                    self.isKeyboardVisible = false
                    self.contentOffset = .zero
                }
            }
        
    }
    
    func validateUserInput(firstName: String, lastName: String, email: String) -> Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            errorMessage = "All fields are required"
            errorMessageShow = true
            return false
        }
        
        guard email.contains("@") else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        let email = email.split(separator: "@")
        
        guard email.count == 2 else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        guard email[1].contains(".") else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        errorMessageShow = false
        errorMessage = ""
        return true
    }
}

#Preview {
    Onboarding()
}


