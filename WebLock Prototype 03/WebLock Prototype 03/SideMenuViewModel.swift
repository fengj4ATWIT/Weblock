//
//  SideMenuViewModel.swift
//  WebLock Prototype 03
//
//  Created by allanshemah on 3/27/23.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable{
    case accountmanagement
    case linkvpn
    case firewall
    case logout
    
    var title: String{
        switch self {
        case.accountmanagement: return "Account Management"
        case.linkvpn: return "Link VPN"
        case.firewall: return "Firewall Configuration"
        case.logout: return "Logout"
        }
    }
    
    var imageName: String{
        switch self {
        case.accountmanagement: return "person"
        case.linkvpn: return "link"
        case.firewall: return "gear"
        case.logout: return "arrow.left.square"
            
        }
    }
}
