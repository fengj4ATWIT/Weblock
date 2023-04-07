//
//  AccountManagementView.swift
//  WebLock
//
//  Created by allanshemah on 4/4/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

struct AccountManagementView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var alertIsPresented = false
    @State private var alertIsPresented2 = false
    @State var email = ""
    @State var password = ""
    
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
                    
                    Color("Color 2"),
                    Color("Color 2"),
                    Color("Color 3"),
                    Color("Color 3"),
                    
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack{
                    
                    TextField("Enter New Email", text: $email)
                        .frame(width: 320, height: 20)
                        .padding()
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .padding()
                        
                    
                    
                    Button("Change Email") {
                        Auth.auth().currentUser?.updateEmail(to: email) { error in
                            if let error = error{
                                print(error.localizedDescription)
                                return
                            }
                           
                        }
                        alertIsPresented = true
                    }
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .cornerRadius(8)
                    .background(.blue)
                    .padding()
                    .alert(isPresented: $alertIsPresented){
                        Alert(title: Text("Success"), message: Text("Email Changed"), dismissButton: .default(Text("OK")))
                    }

                    
                    VStack{
                        TextField("Enter New Password", text: $password)
                            .frame(width: 320, height: 20)
                            .padding()
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .padding()
                            
                        
                    }
                    
                        
                    
                    Button("Change Password") {
                        Auth.auth().currentUser?.updatePassword(to: password) { error in
                            if let error = error{
                                print(error.localizedDescription)
                                return
                            }
                          
                        }
                        alertIsPresented2 = true
                        
                    }
                    .foregroundColor(Color.white)
                    .frame(width:200, height: 50)
                    .cornerRadius(8)
                    .background(.blue)
                    .padding()
                    .alert(isPresented: $alertIsPresented2){
                        Alert(title: Text("Success"), message: Text("Password Changed"), dismissButton: .default(Text("OK")))
                    }
                    
                    Spacer()
                    
                    
                    

                }
            }
            .navigationTitle("Account Management")
        }
    }
}

struct AccountManagementView_Previews: PreviewProvider {
    static var previews: some View {
        AccountManagementView()
            .environmentObject(AppViewModel())
    }
}
