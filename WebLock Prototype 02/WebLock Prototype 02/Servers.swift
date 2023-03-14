//
//  Servers.swift
//  WeblockProj
//
//  Created by Donna  Xu on 3/09/23.
//

import SwiftUI

struct Server: Identifiable {

    var id = UUID().uuidString
    var name: String
    var flag: String
}

var servers = [
    
    Server(name: "Raspberry PI", flag: "raspberry-pi-logo"),
]
