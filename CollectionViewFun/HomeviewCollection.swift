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
    
    // TODOs - Paging layout , Pinteesty layout, UIDynamics , Gesture support, Data-driven layout
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
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
       
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("homeCell", forIndexPath: indexPath) as! navigationItemCellCollectionViewCell
        
        cell.nameLabel.text = itemsNames[indexPath.row]
        return cell
    }
    
  
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("pushToEdgesFade", sender: self)
        case 1:
            self.performSegueWithIdentifier("pushToTransform", sender: self)
        case 2:
            self.performSegueWithIdentifier("pushSticky", sender: self)
            
        default:
            NSLog("nothing")
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
