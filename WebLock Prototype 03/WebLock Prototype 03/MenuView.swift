//
//  MenuView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/27/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [
                
                Color("BG1"),
                Color("BG1"),
                Color("BG2"),
                Color("BG2"),
                
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
           
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
