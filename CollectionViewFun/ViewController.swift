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
    @IBOutlet weak var layoutFadeEdges: LayoutFadeEdges!
   
    var items:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Customize FlowLayoutClass
        layoutFadeEdges.itemSize = CGSizeMake(50, 50)
        layoutFadeEdges.scrollDirection = .Vertical
        
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.addObject("\(char)")
        }
        
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.addObject("\(char)")
        }
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.addObject("\(char)")
        }
        for char in "abcdefghijklmnopqrstuvwxyz" {
            items.addObject("\(char)")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// FlowLayout expects delegate methods to be implemeted here
extension ViewController : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       
        var cell:CustomCellCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as CustomCellCollectionViewCell
        return cell
    }
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}
