//
//  NewReleasesCollectionViewCell.swift
//  SpotyApp
//
//  Created by Alberto Tsang on 5/25/19.
//  Copyright © 2019 kicyiusoft. All rights reserved.
//

import UIKit

class NewReleaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var newReleaseNameLabel: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    var newReleaseResult: NewReleaseResult? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        if let newReleaseResult = newReleaseResult {
            if let imageURL = URL(string: newReleaseResult.imageURL) {
                downloadTask = featuredImageView.loadImage(url: imageURL)
            }
           
            newReleaseNameLabel.text = newReleaseResult.name
        } else {
            featuredImageView.image = UIImage(named: "noimage")
            newReleaseNameLabel.text = ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}


