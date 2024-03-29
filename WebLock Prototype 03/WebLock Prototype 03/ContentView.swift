//
//  ContentView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/18/23.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import _AuthenticationServices_SwiftUI

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

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var user = Auth.auth().currentUser
    @EnvironmentObject var viewModel: AppViewModel
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
        NavigationView{
            
            
            
            if  viewModel.signedIn {
                VStack{
               
                    Home()
                }
                if log_Status == true{
                    VStack{
                        Home()
                    }
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

struct SignInView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var alertIsPresented = false
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    @StateObject var loginData = AppleSignInViewModel()
    @AppStorage("log_Status") var log_Status = false
   
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    var body: some View {
        
        
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
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        
                    
                    SecureField("Password", text: $password)
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
                        .padding()
                    
                    
                    NavigationLink("Forgot Password", destination: ForgotPasswordView())
                    
                    //GoogleSigninBtn {
                   // GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) {  result, error in                    //}
                    
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
                            
                                //Success
                               // viewModel.signedIn = true
                            
                            // At this point, our user is signed in
                            
                               //display user
                                //guard let user = result?.user else{
                                   // return
                                //}
                               // print(user.displayName ?? "Success!")
                                
                                //updating user as logged in
                            withAnimation {
                                log_Status = true
                            }
                           
                          
                            
                            // ...
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
                    .padding()
                    
                    SignInWithAppleButton { (request) in
                        
                        //getting error or success
                        loginData.nonce = randomNonceString()
                        request.requestedScopes = [.email,.fullName]
                        request.nonce = sha256(loginData.nonce)
                        
                    } onCompletion: { (result) in
                        switch result{
                        case.success(let user):
                            print("Success")
                            //do login with firebase
                            guard let credential = user.credential as?
                                    ASAuthorizationAppleIDCredential else{
                                        print("error with firebase")
                                        return
                                    }
                            viewModel.signedIn = true
                            loginData.authenticate(credential: credential)
                        case.failure(let error):
                            print(error.localizedDescription)
                        }
                        
                    }
                    .signInWithAppleButtonStyle(.white)
                    .frame(height:55)
                    .clipShape(Capsule())
                    .padding(.horizontal,40)
                    
                }
                    
                  
                
            }
                
                .padding()
                
                Spacer()
                
            }
        .navigationTitle("WebLock")
        }
        
        
        
    }
        



struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
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

struct ForgotPasswordView: View {
    @State var email = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
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
                TextField("Enter Email", text: $email)
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
struct Home: View {
    @State var isConnected = false
    @EnvironmentObject var viewModel: AppViewModel
    @State var currentServer: Server = servers.first!
    @State var changeServer = false
    @State private var showMenu: Bool = false
    @AppStorage("log-status") var log_status = false
    var body: some View {
        NavigationStack{
            VStack{
                
                HStack{
                   
                    Button {
                        viewModel.signOut()
                        
                    }
                  label: {
                            Image(systemName: "arrow.left.square")
                                .font(.title)
                                .padding(12)
                                .background(
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.white.opacity(0.25),lineWidth: 1)
                                )
                        }
                  
                    
                        Spacer()
                      
                        Menu {
                          
                       
                            NavigationLink("Link VPN"){
                                LinkVPNView()
                            }
                        
                            NavigationLink("Account Management"){
                                AccountView()
                            }
                            Button {
                                
                            } label: {
                                Text("FireWall Configuration")
                                                            }
                            

                        //self.showMenu.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title2)
                                .padding(12)
                                .background(
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.white.opacity(0.25),lineWidth: 1)
                                )
                        }
                        
                    }
              
                    .overlay(
                       
                        
                        Text(getTitle())
                        
                    )
                    .foregroundColor(.white)
                    
                
                PowerButton()
                
                
                VStack{
                    
                    Label {
                        
                        Text(isConnected ? "Connected" : "Not Connected")
                        
                    } icon: {
                        Image(systemName: isConnected ? "checkmark.shield" : "shield.slash")
                    }
                    .font(.system(size: 18, weight: .semibold))
                    
                    
                    Spacer()
                    
                    HStack{
                        
                        HStack{
                            
                            Image(systemName: "arrow.down.to.line.circle")
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Download")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                Text("\(isConnected ? "60.0" : "0") KB/s")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                      
                        HStack{
                            
                            Image(systemName: "arrow.up.to.line.circle")
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Text("Upload")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                Text("\(isConnected ? "27.5" : "0") KB/s")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .frame(width: getRect().width - 100)
                }
                .animation(.none, value: isConnected)
                // Max Frame...
                .frame(height: 120)
                .padding(.top,getRect().height < 750 ? 20 : 40)
                
            }
            
            
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .background(
                
                Background()
                
            )
            
            .overlay(
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .opacity(changeServer ? 1 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation{
                            changeServer.toggle()
                        }
                        
                    }
            )
            .overlay(
        GeometryReader{ _ in
            HStack{
              Spacer()
                //SideMenuView()
                
                    .offset(x: showMenu ? 0 : UIScreen.main.bounds.width
                    
                )
            }
        }
            .background(Color.black.opacity(showMenu ? 0.5 : 0))
            .animation(Animation.easeIn.delay(0.05))
            .onTapGesture {
                self.showMenu.toggle()
            }
            )
            .overlay(
                BottomSheet(),
                
                alignment: .bottom
                
            )
            .ignoresSafeArea(.container, edges: .bottom)
            
            .preferredColorScheme(.dark)
            
            
            
        }//navigation title
        
    }
    

    @ViewBuilder
    func BottomSheet()->some View{
        
        VStack(spacing: 0){
            
            
            HStack{
                
                Image(currentServer.flag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(currentServer.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(isConnected ? "Currently Connected" : "Currently Selected")
                        .font(.caption2.bold())
                }
                
                Spacer(minLength: 10)
                
             
                Button {
                    withAnimation{
                        changeServer.toggle()
                    }
                } label: {
                    
                    Text(changeServer ? "Exit" : "Change")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: 110,height: 45)
                        .background(
                        
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.white.opacity(0.25),lineWidth: 2)
                        )
                        .foregroundColor(.white)
                }

            }
            .frame(height: 50)
            .padding(.horizontal)
            
            Divider()
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 18) {
                    
                   
                    ForEach(servers.filter{
                        $0.id != currentServer.id
                    }){server in
                        
                        VStack(spacing: 12){
                            
                            HStack{
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    HStack{
                                        
                                        Image(server.flag)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                        
                                        Text(server.name)
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                    }
                                    
                                    Label {
                                        
                                        Text("Available, Ping 992ms")
                                        
                                    } icon: {
                                        Image(systemName: "checkmark")
                                    }
                                    .foregroundColor(.green)
                                    .font(.caption2)
                                }

                                
                                Spacer(minLength: 10)
                                
                               
                                Button {
                                    withAnimation{
                                        changeServer.toggle()
                                        currentServer = server
                                        isConnected = false
                                    }
                                } label: {
                                    
                                    Text("Change")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 100,height: 45)
                                        .background(
                                        
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(.white.opacity(0.25),lineWidth: 2)
                                        )
                                        .foregroundColor(.white)
                                }
                                
                                Button {
                                    
                                } label: {
                                    
                                    Image(systemName: "square.and.arrow.up")
                                    
                                    .frame(width: 45,height: 45)
                                    .background(
                                    
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(.white.opacity(0.25),lineWidth: 2)
                                    )
                                    .foregroundColor(.white)
                                }


                            }
                            .frame(height: 50)
                            .padding(.horizontal)
                            
                            Divider()
                        }
                    }
                }
                .padding(.top,25)
                .padding(.bottom,getSafeArea().bottom)
            }
            .opacity(changeServer ? 1 : 0)
        }
        .frame(maxWidth: .infinity)
        // Max Height...
        .frame(height: getRect().height / 2.5,alignment: .top)
        .padding()
        .background(
        
        )
      
        .offset(y: changeServer ? 0 : (getRect().height / 2.5) - (50 + getSafeArea().bottom))
    }
    
    @ViewBuilder
    func Background()->some View{
        
        ZStack{
            
            LinearGradient(colors: [
            
                Color("BG1"),
                Color("BG1"),
                Color("BG2"),
                Color("BG2"),
                
            ], startPoint: .top, endPoint: .bottom)
            
            
            Image("mars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
                .scaleEffect(getRect().height < 750 ? 0.8 : 1)
          
                .position(x: 50, y: getRect().height < 750 ? 200 : 220)
                .opacity(0.7)
            
            
            let stars: [CGPoint] = [
            
                CGPoint(x: 15, y: 190),
                CGPoint(x: 25, y: 250),
                CGPoint(x: 20, y: 350),
                CGPoint(x: getRect().width - 30, y: 240),
            ]
            
            ForEach(stars,id: \.x){star in
                
                Circle()
                    .fill(.white.opacity(0.3))
                    .frame(width: 5, height: 5)
                    .position(star)
                    .offset(y: getRect().height < 750 ? -20 : 0)
            }
            
          
            Image("globe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width,height: getRect().width)
                .scaleEffect(1.5)
                .offset(y: getRect().height < 750 ? 310 : 280)
           
                .frame(maxHeight: .infinity,alignment: .bottom)
        }
        .ignoresSafeArea()
    }
    
    func getTitle()->AttributedString{
        var str = AttributedString("WebLock")
        
        if let range = str.range(of: "Web"){
            str[range].font = .system(size: 24, weight: .light)
        }
        
        if let range = str.range(of: "Lock"){
            str[range].font = .system(size: 24, weight: .black)
        }
        
        return str
    }
    

    @ViewBuilder
    func PowerButton()->some View{
        
        Button {
            
            withAnimation{
                isConnected.toggle()
            }
            
        } label: {

            ZStack{
                
                Image(systemName: "power")
                    .font(.system(size: 65, weight: .medium))
                    .foregroundColor(isConnected ? .white : Color("Power"))
                
                    .scaleEffect(isConnected ? 0.7 : 1)
                    .offset(y: isConnected ? -30 : 0)
                
                Text("DISCONNECT")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y: 20)
                    .opacity(isConnected ? 1 : 0)
            }
            
            .frame(width: 190,height: 190)
            .background(
            
                ZStack{
                    
                  
                    Circle()
                        .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 : 0.5)
                        .stroke(
                        
                            LinearGradient(colors: [
                            
                                Color("Ring1"),
                                Color("Ring1")
                                    .opacity(0.5),
                                Color("Ring1")
                                    .opacity(0.3),
                                Color("Ring1")
                                    .opacity(0.1),
                                
                            ], startPoint: .leading, endPoint: .trailing),
                            
                            style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                        )
                 
                        .shadow(color: Color("Ring1"), radius: 5, x: 1, y: -4)
                    
                    Circle()
                        .trim(from: isConnected ? 0 : 0.3, to: isConnected ? 1 : 0.55)
                        .stroke(
                        
                            LinearGradient(colors: [
                            
                                Color("Ring2"),
                                Color("Ring2")
                                    .opacity(0.5),
                                Color("Ring2")
                                    .opacity(0.3),
                                Color("Ring2")
                                    .opacity(0.1),
                                
                            ], startPoint: .leading, endPoint: .trailing),
                            
                            style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round)
                        )
                        .shadow(color: Color("Ring2"), radius: 5, x: 1, y: -4)
                        .rotationEffect(.init(degrees: 160))
                    
                   
                    Circle()
                        .stroke(
                        
                            Color("Ring1")
                                .opacity(0.01),
                            lineWidth: 11
                        )
                    
                        .shadow(color: Color("Ring2").opacity(isConnected ? 0.04 : 0), radius: 5, x: 1, y: -4)
                }
            )
        }
        .padding(.top,getRect().height < 750 ? 30 : 100)
    }
}


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
                    
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                    
                    
                    Button {
                        Auth.auth().currentUser?.updateEmail(to: email) { error in
                            if error != nil {
                                print("error")
                            }else{
                                print("Changed")
                                
                            }
                            
                        }
                        
                    } label: {
                        Text("Change Email")
                            .foregroundColor(.white)
                            .frame(width:200, height: 50)
                            .cornerRadius(8)
                            .background(.blue)
                            .padding()
                    }
                    
                    
                    TextField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .autocapitalization(.none)
                    Button {
                        Auth.auth().currentUser?.updatePassword(to: password) { error in
                            
                            // ...
                        }
                        
                    } label: {
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
            .navigationTitle("Account Management")
            
        }
        .navigationTitle("Account Management")
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
        
    }
}
extension View{
  
    
    func getRect()->CGRect{
        UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
    
}



