//
//  SideMenuView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/25/23.
//

import SwiftUI

struct SideMenuView: View {
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .foregroundColor(.white)
            Spacer()
            
            VStack{
                ForEach(SideMenuViewModel.allCases, id:  \.self) { option in
                    NavigationLink(destination: SignInView(), label:{ OptionsView(viewModel: option)
                    })
                   
                }
                
                    Spacer()
                }
                
            }
            .padding(16)
            .background(Color.black)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    struct SideMenuView_Previews: PreviewProvider {
        static var previews: some View {
            SideMenuView()
        }
    }

