//
//  OptionsView.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/27/23.
//

import SwiftUI

struct OptionsView: View {
    let viewModel: SideMenuViewModel
    
    var body: some View {
        
            
        
        HStack(spacing: 16){
            Image(systemName: viewModel.imageName)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
            
            Text(viewModel.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
                .padding()
        }
        
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(viewModel: .accountmanagement)
        OptionsView(viewModel: .linkvpn )
        
    }
}
