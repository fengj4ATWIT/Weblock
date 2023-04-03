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
    @State var email = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                TextField("Enter Email", text: $email)
            }
        }
        .navigationTitle("Account Management")
    }
}

struct AccountManagementView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
