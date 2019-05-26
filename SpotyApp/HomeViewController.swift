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
    
    @IBOutlet weak var collectioView: UICollectionView!
    let cellScaling: CGFloat = 0.6
    
    private var dataTask: URLSessionDataTask? = nil
    private var countries = [Country]()
    private var newReleaseResults = [NewReleaseResult]()
    private let newRelease = NewRelease()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newRelease.getNewReleases(finished: { response in
            self.newReleaseResults = response
            for newRelease in self.newReleaseResults {
                print("getNewReleases name : \(newRelease.name)")
                print("getNewReleases imageURL : \(newRelease.imageURL)")
                
                
            }
            
            self.initCollectionView()
            
        })
        
        
    }
    
    func initCollectionView() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        print("view width is: \(view.bounds.width)" )
        print("view height is: \(view.bounds.height)" )
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectioView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectioView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectioView?.dataSource = self
        collectioView?.delegate = self
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newReleaseResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectioView.dequeueReusableCell(withReuseIdentifier: "NewReleaseCell", for: indexPath) as! NewReleaseCollectionViewCell
        
        cell.newReleaseResult = newReleaseResults[indexPath.item]
        
        return cell
    }
}

extension HomeViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectioView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        print("layout.itemSize.width: \(layout.itemSize.width)" )
        print("layout.minimumLineSpacing: \(layout.minimumLineSpacing)" )
        var offset = targetContentOffset.pointee
        
        //index: to know the item to set
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        print("cellWidthIncludingSpacing: \(cellWidthIncludingSpacing)" )
        print("offset: \(offset)" )
        print("scrollView contentInset left: \(scrollView.contentInset.left)" )
        print("index: \(index)" )
        print("rounded index: \(roundedIndex)" )
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
        print("offset: \(offset)" )
        
    }
}

