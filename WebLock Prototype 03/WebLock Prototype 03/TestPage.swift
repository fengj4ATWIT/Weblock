//
//  TestPage.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 4/2/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

struct TestPage: View {
    var body: some View {
        VStack{
            Text("Google Sign In")
            
            VStack{
                Button {
                  
                } label: {
                    HStack(spacing: 15){
                        Image("google")
                            .resizable()
                            .frame(width: 28,height: 28)
                        
                        Text("Create Account")
                            .font(.title3)
                            .fontWeight(.medium)
                            .kerning(1.1)
                            .foregroundColor(.white)
                        
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    //
                    .background(
                        Capsule()
                            .strokeBorder(Color.white)
                    )
                }
                .padding(.top,40)
            }
        }
    }
}


    

struct TestPage_Previews: PreviewProvider {
    static var previews: some View {
        TestPage()
    }
}

