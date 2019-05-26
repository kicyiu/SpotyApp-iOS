//
//  NewRelease.swift
//  SpotyApp
//
//  Created by Alberto Tsang on 5/18/19.
//  Copyright © 2019 kicyiusoft. All rights reserved.
//

import UIKit

class NewRelease {
        
    private let spotifyService = SpotifyServices()
    private let helper = Helper()
    
    /*
    init(name: String, capital: String) {
        self.name = name
    }*/
    
    public func getNewReleases(finished: @escaping (([NewReleaseResult])->Void)) {
        spotifyService.getNewReleases(finished: { response in
            if let jsonDictionary = self.helper.parse(json: response) {
                let newReleasesList = self.parse(dictionary: jsonDictionary)
                finished(newReleasesList)
            }
            
        })
    }
    
    
    
    private func parse(dictionary: [String: Any]) -> [NewReleaseResult] {
        // 1

        
        let dic = dictionary["albums"] as! [String:Any]
        
        let array = dic["items"]  as! [Any]
        
        var newReleaseResults: [NewReleaseResult] = []
        
        for resultDict in array {
            if let resultDict = resultDict as? [String: Any] {
                let imagesArray =  resultDict["images"] as! [Any]
                if imagesArray.count > 0 {
                    let imgItem = imagesArray[0] as! [String: Any]
                    let newReleaseResult = NewReleaseResult(name: resultDict["name"] as! String, imageURL: imgItem["url"] as! String)
                    
                    newReleaseResults.append(newReleaseResult)
                }
                else {
                    let newReleaseResult = NewReleaseResult(name: resultDict["name"] as! String, imageURL: "")
                    
                    newReleaseResults.append(newReleaseResult)
                }
                
                

                
            }
            
            
        }
        
        return newReleaseResults
    }
    
    
    
    
}
