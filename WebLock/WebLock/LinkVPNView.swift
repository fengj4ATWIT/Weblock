//
//  LinkVPNView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/27/23.
//

import SwiftUI

struct LinkVPNView: View {
    @State var IPAddress = ""
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
                    
                    Color("Color 2"),
                    Color("Color 2"),
                    Color("Color 3"),
                    Color("Color 3"),
                    
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                VStack{
                    
                   
                    Text("Enter Raspberry Pi IP Address")
                        .padding()
                        .foregroundColor(.white)
                    
                    TextField("IP Address Here", text: $IPAddress)
                        .frame(width: 370 , height: 40)
                        .background(Color.white)
                        .padding()
                    Button {
                        
                    } label: {
                        Image(systemName: "link")
                        Text("Link to VPN")
                    }
                    .foregroundColor(.white)
                    .frame(width:200, height: 50)
                    .cornerRadius(8)
                    .background(.pink)
                    .padding()
                    
                    HStack{
                        Image(systemName: "exclamationmark.bubble.circle.fill")
                        Text("How to find IP Address")
                            .padding()
                    }
                    
                    Spacer()
                }
               
            }
            .navigationTitle("Link VPN")
            
            }
           
        }
        
    }


struct LinkVPNView_Previews: PreviewProvider {
    static var previews: some View {
        LinkVPNView()
            .environmentObject(AppViewModel())
    }
}
