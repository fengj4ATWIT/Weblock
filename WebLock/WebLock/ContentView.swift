//
//  ContentView.swift
//  WebLock
//
//  Created by allanshemah on 4/4/23.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import _AuthenticationServices_SwiftUI
import AuthenticationServices

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var user = Auth.auth().currentUser
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            
            if  viewModel.signedIn {
                VStack{
               
                    Home()
                }
               
            }
                else{
                    VStack{
                        SignInView()
                    }
                    
                }
            
            }
                .onAppear{
                    viewModel.signedIn = viewModel.isSignedIn
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
    }
}
