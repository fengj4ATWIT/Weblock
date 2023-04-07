//
//  SignUpView.swift
//  WebLock
//
//  Created by allanshemah on 4/4/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    var body: some View {
        ZStack{
            LinearGradient(colors: [
                
                Color("Color 2"),
                Color("Color 2"),
                Color("Color 3"),
                Color("Color 3"),
                
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack{
                
            VStack{
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white);                    SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                
                Button {
                    guard !email.isEmpty, !password.isEmpty
                    else{
                        return
                    }
                    
                    viewModel.signUp(email: email, password: password)
                    
                } label: {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .frame(width:200, height: 50)
                        .cornerRadius(8)
                        .background(.blue)
                        .padding()
                }
                
                
            }
            .padding()
            
            Spacer()
            
        }
            
            }
            .navigationTitle("Create Account")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AppViewModel())
    }
}
