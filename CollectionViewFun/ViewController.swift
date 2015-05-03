//
//  ViewController.swift
//  CollectionViewFun
//
//  Created by Zach McArtor on 3/20/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var items:[String]!
    var numberOfSections = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Customize FlowLayoutClass
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(50, 50)
       
        NSLog("Section inset : %@", NSStringFromUIEdgeInsets(layout.sectionInset));
        
        items = []
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.append("\(char)")
        }
        
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.append("\(char)")
        }
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.append("\(char)")
        }
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.append("\(char)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// FlowLayout expects delegate methods to be implemeted here
extension ViewController : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        var cell:CustomCellCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! CustomCellCollectionViewCell
        
        cell.letterLabel.text = items[indexPath.row]
        
        return cell
    }
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
}
