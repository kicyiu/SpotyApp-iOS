//
//  spotifyServices.swift
//  SpotyApp
//
//  Created by Alberto Tsang on 5/19/19.
//  Copyright © 2019 kicyiusoft. All rights reserved.
//

import Foundation
import UIKit

class SpotifyServices {
    
    private var dataTask: URLSessionDataTask? = nil
    private var token = "BQCKycEgvn16eIBZ5geQFQGtQ7AtOqtOhR1cmU6bicyN85tKmIvTpLm5JKFvMWN8sylAzCVDvTY8a2aVWtU"
    
    private var url = "https://api.spotify.com/v1/"
    
    
    
    public func getNewReleases()  {
        let url = spotifyURL("browse/new-releases")
        getQuery(query: url, finished: { response in
            // Handle logic after return here
            print("getNewReleases response : \(response)")
        })
        
       

    }
    
    private func spotifyURL(_ name: String) -> URL {
        let urlString = String(format: "\(url)\(name)")
        let url = URL(string: urlString)
        print("URL: \(url!)")
        return url!
    }
    
    private func getQuery(query: URL, finished: @escaping ((Any)->Void)) {
        
        dataTask?.cancel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let session = URLSession.shared
        
        
        var request = URLRequest(url: query)
        request.httpMethod = "GET"
        
        // insert json data to the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        //dataTask = session.dataTask(with: url, completionHandler: {
        dataTask = session.dataTask(with: request, completionHandler: {
            data, response, error in
            
            if let error = error as? NSError, error.code == -999 {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let jsonData = data {
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        finished(jsonData)
                    }
                
                
                } else {
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        finished(false)
                    }
                }
            
        })
        dataTask?.resume()
        
    }
    
}
