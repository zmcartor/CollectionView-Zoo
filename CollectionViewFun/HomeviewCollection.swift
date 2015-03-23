//
//  HomeviewCollection.swift
//  CollectionViewFun
//
//  Created by Zach McArtor on 3/21/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

import UIKit

class HomeviewCollection: UICollectionViewController {
    
    let itemsNames = ["Fade out edges" , "Transform edges", "Sticky headers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView!.collectionViewLayout as UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 3.0
        
        self.title = "Zoo"
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
    
  
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        // TODO make a cool Swift swtich statement
        if indexPath.row == 0 {
                self.performSegueWithIdentifier("pushToEdgesFade", sender: self)
        }
        else if indexPath.row == 1 {
            self.performSegueWithIdentifier("pushToTransform", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //prepare, pass data if needed
    }
   
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
           
            let width = view.window!.bounds.width
            return CGSize(width: width, height: 50)
    }
}
