//
//  SignInView.swift
//  WebLock
//
//  Created by allanshemah on 4/3/23.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import _AuthenticationServices_SwiftUI
import AuthenticationServices

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published private var alertIsPresented = false
    var isSignedIn : Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self]result , error in
            guard result != nil, error == nil
            else{
                self?.alertIsPresented = true
                return
            }
            DispatchQueue.main.async{
                //Success
                self?.signedIn = true
                
            }
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self]result, error in
            guard result != nil, error == nil
            else{
                return
            }
            DispatchQueue.main.async{
                //Success
                self?.signedIn = true
            }
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        try? auth.signOut()
       
    
       self.signedIn = false
    }
    
    func resest(email: String){
        auth.sendPasswordReset(withEmail: email)
    }
    
}

struct SignInView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var alertIsPresented = false
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @AppStorage("log_Status") var log_Status = false
    @AppStorage("email") var aemail: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
   
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
              Image("AppIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 200)
                    .padding()
                VStack{
                    TextField("Email", text: $email)
                        .frame(width: 300, height: 20)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        
                    
                    SecureField("Password", text: $password)
                        .frame(width: 300, height: 20)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                       
                    
                    Button("Sign In"){
                        
                        guard !email.isEmpty, !password.isEmpty
                        else{
                            self.alertIsPresented = true
                            return
                        }
                            
                        viewModel.signIn(email: email, password: password)
                        
                    }
                       
                            .foregroundColor(.white)
                            .frame(width:200, height: 50)
                            .cornerRadius(8)
                            .background(.blue)
                            .padding()
                            .alert(isPresented: $alertIsPresented){
                                Alert(title: Text("Error"), message: Text("Enter email and password"), dismissButton: .default(Text("OK")))
                            }
                    
                   
                    NavigationLink("Create Account", destination: SignUpView())
                        .foregroundColor(Color.blue)
                        .padding()
                    
                    
                    NavigationLink("Forgot Password", destination: ForgotPasswordView())
                        .foregroundColor(Color.pink)
              
                    
                    Button {
                        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                        // Create Google Sign In configuration object.
                        let config = GIDConfiguration(clientID: clientID)
                        GIDSignIn.sharedInstance.configuration = config

                        // Start the sign in flow!
                        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {  result, error in
                          guard error == nil else {
                            // ...
                              return
                          }

                          guard let user = result?.user,
                            let idToken = user.idToken?.tokenString
                          else {
                            // ...
                              return
                          }

                          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                                         accessToken: user.accessToken.tokenString)

                            Auth.auth().signIn(with: credential) { result, error in
                                if error != nil {
                                    print("error")
                                    return
                                }
                                
                                viewModel.signedIn = true
                                    
                        }
              
                        }
                    } label: {
                        HStack(spacing: 15){
                            Image("google")
                                .resizable()
                                .frame(width: 28,height: 28)
                            
                            Text("Sign In with Google")
                                .font(.title3)
                                .fontWeight(.medium)
                                .kerning(1.1)
                                .foregroundColor(.black)
                            
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        //
                        .background(
                            Capsule()
                                .strokeBorder(Color.white)
                                .background(Color.white)
                                .cornerRadius(90)
                                .frame(width:280,height: 55)
                            
                        )
                        
                    }
                   
                    .padding()
                   
                    
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.email, .fullName]
                        
                    } onCompletion: { result in
                        
                        switch result {
                        case.success(let auth):
                            switch auth.credential{
                            case let credential as ASAuthorizationAppleIDCredential:
                                //User Id
                                let userid = credential.user
                                
                                // User Info
                                let email = credential.email
                                let firstName = credential.fullName?.givenName
                                let lastName = credential.fullName?.familyName
                                
                                self.aemail = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                                self.userId = userid
                               
                                viewModel.signedIn = true
                            default:
                                break
                            }
                            
                            
                        case.failure(let auth):
                            print("error")
                        }
                        
                    }
                    .signInWithAppleButtonStyle(.white)
                    .frame(width: 280, height:55)
                    .clipShape(Capsule())
                    .padding(.horizontal,40)

                    
                }
                    
            }
                
                
                
                Spacer()
                
            }
        .navigationTitle("WebLock")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AppViewModel())
    }
}
