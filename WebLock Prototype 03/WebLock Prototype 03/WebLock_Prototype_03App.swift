//
//  WebLock_Prototype_03App.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/18/23.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        FirebaseApp.configure()
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
}

@main
struct WebLock_Prototype_03App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delagte
    
    var body: some Scene {
        
            let viewModel = AppViewModel()
            WindowGroup {
                ContentView()
                    .environmentObject(viewModel)
                
            }
        
    }
}
