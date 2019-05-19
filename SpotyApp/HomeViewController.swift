//
//  FirstViewController.swift
//  SpotyApp
//
//  Created by Alberto Tsang on 5/18/19.
//  Copyright © 2019 kicyiusoft. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    private var dataTask: URLSessionDataTask? = nil
    private var countries = [Country]()
    private var newReleases = [NewRelease]()
    let spotifyService = SpotifyServices()
    
    private var token = "BQD3GcCqF8Oqzw0hnXFbhLQqVUDiS6YKY__IAFYZ3vgEzX2m-_ULanbY4RWEtJM_txXmGG1cv2l71JgUsqs"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        spotifyService.getNewReleases()
       // getNewReleases()
    }
    
    
    func getNewReleases() {
        dataTask?.cancel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let session = URLSession.shared
        let url = spotifyURL()
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // insert json data to the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        //dataTask = session.dataTask(with: url, completionHandler: {
        dataTask = session.dataTask(with: request, completionHandler: {
            data, response, error in
            
            var success = false
            
            if let error = error as? NSError, error.code == -999 {
                return
            }
        
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let jsonData = data,
                let dictionary = self.parse(json: jsonData) {
                   // print("Success! \(dictionary)")
            }

            
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            
        })
        dataTask?.resume()
    }
    
    private func spotifyURL() -> URL {
        let urlString = String(format: "https://api.spotify.com/v1/browse/new-releases")
        let url = URL(string: urlString)
        print("URL: \(url!)")
        return url!
    }
    
    private func parse(json data: Data) -> [String: Any]? {
        print("data to parse: \(data)")
        
        do {
            return try JSONSerialization.jsonObject(
                with: data, options: []) as? [String: Any]
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
 
        //Decode JSON to readable Object (only with array)
        /*
        do
        {
            let decoder = JSONDecoder()
            return try decoder.decode([NewRelease].self, from: data)
            
            
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
 */
    }


}

