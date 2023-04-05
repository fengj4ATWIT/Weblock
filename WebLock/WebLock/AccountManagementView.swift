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
    
    var body: some View {
        NavigationView{
            ZStack{
               
                
                VStack{
                    
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .padding()
                        .background(Color.black)
                    
                    
                    Button("Change Email") {
                        Auth.auth().currentUser?.updateEmail(to: email) { error in
                            if let error = error{
                                print(error.localizedDescription)
                                return
                            }
                           
                        }
                        alertIsPresented = true
                    }
                    .alert(isPresented: $alertIsPresented){
                        Alert(title: Text("Success"), message: Text("Email Changed"), dismissButton: .default(Text("OK")))
                    }

                    
                    
                    TextField("Enter New Password", text: $password)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.black)
                    
                    Button("Change Password") {
                        Auth.auth().currentUser?.updatePassword(to: password) { error in
                            if let error = error{
                                print(error.localizedDescription)
                                return
                            }
                          
                        }
                        alertIsPresented2 = true
                        
                    }
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
