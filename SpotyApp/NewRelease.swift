//
//  NewRelease.swift
//  SpotyApp
//
//  Created by Alberto Tsang on 5/18/19.
//  Copyright © 2019 kicyiusoft. All rights reserved.
//

import UIKit

class NewRelease: Codable {
    
    let name: String
    
    init(name: String, capital: String) {
        self.name = name
    }
    
    
}
