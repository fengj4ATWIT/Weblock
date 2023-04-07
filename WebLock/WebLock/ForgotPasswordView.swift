//
//  ForgotPasswordView.swift
//  WebLock
//
//  Created by allanshemah on 4/4/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct ForgotPasswordView: View {
    @State var email = ""
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
                TextField("Enter Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white);
                
                Button {
                    guard !email.isEmpty
                    else{
                        return
                    }
                    
                    viewModel.resest(email: email)
                    
                    
                } label: {
                    Text("Send Reset Link")
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
            .navigationTitle("Forgot Password")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(AppViewModel())
    }
}
