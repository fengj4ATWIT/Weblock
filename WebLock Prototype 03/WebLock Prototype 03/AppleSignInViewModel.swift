//
//  AppleSignInViewModel.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/30/23.
//

import SwiftUI
//needed cryptokit
import CryptoKit
import AuthenticationServices
import Firebase
class AppleSignInViewModel: ObservableObject{
    
    @Published var nonce = ""
    @AppStorage("log-status") var log_Status = false
    
    func authenticate(credential: ASAuthorizationAppleIDCredential){
        //getting token
        guard let token = credential.identityToken else{
        print("error with firebase")
        return
        }
        
        //Token String
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("eroor with Token")
            return
        }
        let firebasecredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebasecredential) { [self] (result,err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            //user successfully logged into firebase
            print("login success")
            
            //directing user to home page
            withAnimation(.easeInOut){
                log_Status = true
            }
        }
    }
    
}
// helpers for Apple Login With Firebase

func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}
