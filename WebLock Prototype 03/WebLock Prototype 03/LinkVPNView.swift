//
//  LinkVPNView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/27/23.
//

import SwiftUI

struct LinkVPNView: View {
    var body: some View {
        NavigationView{
           
            VStack{
                Button{
                    
                } label:{
                    Text("Search for Raspberry Pi")
                }
            }
            .navigationTitle("Link VPN")
        }
    }
}

struct LinkVPNView_Previews: PreviewProvider {
    static var previews: some View {
        LinkVPNView()
    }
}
