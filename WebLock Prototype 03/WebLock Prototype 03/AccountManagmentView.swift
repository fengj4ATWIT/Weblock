//
//  AccountManagmentView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/27/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct AccountManagmentView: View {
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
        NavigationView{
        ZStack{
            LinearGradient(colors: [
                
                Color("BG1"),
                Color("BG1"),
                Color("BG2"),
                Color("BG2"),
                
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack{
                VStack{
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white);
                    
                    Button {
                        Auth.auth().currentUser?.updateEmail(to: email) { error in
                          // ...
                        }                    } label: {
                        Text("Change Email")
                            .foregroundColor(.white)
                            .frame(width:200, height: 50)
                            .cornerRadius(8)
                            .background(.blue)
                            .padding()
                    }
                    
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .autocapitalization(.none)
                    Button {
                        Auth.auth().currentUser?.updatePassword(to: password) { error in
                          // ...
                        }                    } label: {
                        Text("Change Password")
                            .foregroundColor(.white)
                            .frame(width:200, height: 50)
                            .cornerRadius(8)
                            .background(.blue)
                            .padding()
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Delete Account")
                            .foregroundColor(.white)
                            .frame(width:200, height: 50)
                            .cornerRadius(8)
                            .background(.blue)
                            .padding()
                    }

                }
                .padding()
                
                
            }
            
        }
        .navigationTitle("Account Management")
            
    }
        .navigationTitle("Account Management")
    }
    
    struct AccountManagmentView_Previews: PreviewProvider {
        static var previews: some View {
            AccountManagmentView()
        }
    }
}
