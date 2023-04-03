//
//  AccountManagementView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 4/2/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

struct AccountView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var alertIsPresented = false
    @State var email = ""
    @State var password = ""
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    
                    TextField("    Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.top,80)
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
                        alertIsPresented = true
                        
                    }
                    .alert(isPresented: $alertIsPresented){
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
        AccountView()
    }
}
