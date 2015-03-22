//
//  HomeviewCollection.swift
//  CollectionViewFun
//
//  Created by Zach McArtor on 3/21/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

import UIKit

class HomeviewCollection: UICollectionViewController {
    
    let itemsNames = ["Fade out edges" , "transform edges", "stickey headers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView!.collectionViewLayout as UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 3.0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsNames.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("homeCell", forIndexPath: indexPath) as navigationItemCellCollectionViewCell
       
        cell.nameLabel.text = itemsNames[indexPath.row]
        return cell
    }
   
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
           
            let width = view.window!.bounds.width
            return CGSize(width: width, height: 50)
    }
}
