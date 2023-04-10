//
//  FirewallConfig.swift
//  WebLock
//
//  Created by allanshemah on 4/6/23.
//

import SwiftUI

struct FirewallConfig: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    @State private var isOn = false
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [
                    
                    Color("Color 2"),
                    Color("Color 2"),
                    Color("Color 3"),
                    Color("Color 3"),
                    
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                VStack{
                    Toggle("Firewall", isOn: $isOn)
                        .foregroundColor(.white)
                        .frame(width: 380)
                        .padding()
                    Button {
                        
                    } label: {
                        Text("Access Point Configuration")
                    }
                    .foregroundColor(.white)
                    .frame(width:200, height: 50)
                    .cornerRadius(8)
                    .background(.pink)
                    .padding()
                    
                    HStack{
                        Image(systemName: "exclamationmark.bubble.circle.fill")
                        Text("What is Access Point Configuration")
                    }
                    
                    Button {
                    
                    } label: {
                        Text("Change IP Address")
                    }
                    .foregroundColor(.white)
                    .frame(width:200, height: 50)
                    .cornerRadius(8)
                    .background(.pink)
                    .padding()
                    
                    HStack{
                        Image(systemName: "exclamationmark.bubble.circle.fill")
                        Text("What changing your IP Address means")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Traffic Forwarding")
                    }
                    .foregroundColor(.white)
                    .frame(width:200, height: 50)
                    .cornerRadius(8)
                    .background(.pink)
                    .padding()

                    HStack{
                        Image(systemName: "exclamationmark.bubble.circle.fill")
                        Text("What is Traffic Forwarding")
                      
                    }
                    
                   Spacer()
                }
               
            }
            .navigationTitle("Firewall Configuration")
            
            }
    }
}

struct FirewallConfig_Previews: PreviewProvider {
    static var previews: some View {
        FirewallConfig()
            .environmentObject(AppViewModel())
    }
}
