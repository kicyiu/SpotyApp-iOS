//
//  Utils.swift
//  SpotyApp
//
//  Created by Alberto Tsang on 5/21/19.
//  Copyright © 2019 kicyiusoft. All rights reserved.
//

import Foundation

class Helper {
    
    public func parse(json data: Data) -> [String: Any]? {
        print("data to parse: \(data)")
        
        do {
            return try JSONSerialization.jsonObject(
                with: data, options: []) as? [String: Any]
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
        
        
    }
    
    
}
