//
//  TransformLayout.swift
//  CollectionViewFun
//
//  Created by Zach McArtor on 3/22/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

import UIKit

class TransformLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let attributesArray = super.layoutAttributesForElementsInRect(rect)
        
        // Midpoint changes
        // let midPoint = CGPointMake(CGRectGetMidX(collectionView!.bounds), CGRectGetMidY(collectionView!.bounds))
        
        // Midpoint always stays the same. WHY ? Scrollview adjusts its origin to scroll, maybe it messes up GetMidX ?
        let midPoint = CGPointMake((CGRectGetWidth(collectionView!.bounds)*0.5) , (CGRectGetHeight(collectionView!.bounds) * 0.5))
        let contentOffset = collectionView!.contentOffset
        
        // cast it to that type of optional. But still must unwrap it!
        let attributesArry = super.layoutAttributesForElementsInRect(rect)
        for attributes in attributesArray! as! [UICollectionViewLayoutAttributes] {
            
            if attributes.representedElementCategory != .Cell {
                continue
            }
            
            let cellCenter = attributes.center
            
            // when dealing with attributes, remove the contentOffset to get local window position
            let relativeOffset = cellCenter.y - contentOffset.y
            let distance = max(fabs(midPoint.y - relativeOffset), 0.0)
            
            // how close is it from midpoint? measures how close to top or bottom edge
            let percentage = distance / (CGRectGetHeight(collectionView!.bounds)*0.5)
            
            var transform = CGAffineTransformIdentity
            transform = CGAffineTransformScale(transform, (1-(percentage*0.15)), (1-(percentage*0.15)))
            attributes.transform = transform
        }
        return attributesArray
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
