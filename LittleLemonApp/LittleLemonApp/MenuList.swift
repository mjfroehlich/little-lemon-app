//
//  MenuList.swift
//  LittleLemonApp
//
//  Created by mf on 27.02.2024.
//

import Foundation

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
}
