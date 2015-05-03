//
//  StickyHeaderLayout.swift
//  CollectionViewFun
//
//  Created by Zach McArtor on 3/22/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

import UIKit

class StickyHeaderLayout: UICollectionViewFlowLayout {
  
    // determine bounds for given section
    
    private func frameForSection(section: Int) -> CGRect {
        // index paths for first and last cell
        let numberOfItems:Int = collectionView!.numberOfItemsInSection(section)
        let firstIndexPath = NSIndexPath(forItem: 0, inSection: section)
        let lastIndexPath = NSIndexPath(forItem: numberOfItems-1, inSection: section)
        
        // grab from FlowLayout, check where top cell starts and bottom ends
        let topY = layoutAttributesForItemAtIndexPath(firstIndexPath).frame.origin.y
        let bottomY = CGRectGetMaxY(layoutAttributesForItemAtIndexPath(lastIndexPath).frame)
        
        // build frame for entire section. Expand to include header in the frame
        var finalFrame = CGRectZero
        finalFrame.size.width = collectionView!.bounds.size.width
        finalFrame.origin.y = topY - headerReferenceSize.height // move origin up to accomodate header
        finalFrame.size.height = (topY - bottomY) + headerReferenceSize.height
        
        // don't forget sectionInsets. Adjust origin and height
        finalFrame.origin.y -= sectionInset.top
        finalFrame.size.height += (sectionInset.top + sectionInset.bottom)
        return finalFrame
    }
    
    // return modified header frame
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        
        let attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        
        if elementKind == UICollectionElementKindSectionHeader {
            let sectionFrame = frameForSection(indexPath.section)
            let topOfSection = max(collectionView!.contentOffset.y + collectionView!.contentInset.top, sectionFrame.origin.y)
            
            // where header should stop. take out space for next header and bottomInset.
            // see pic http://dativestudios.com/blog/2015/01/10/collection_view_sticky_headers/
            // bottom of section chosen when two sections bump up agaist each other
            let bottomOfSection = CGRectGetMaxY(sectionFrame) - headerReferenceSize.height - collectionView!.contentInset.bottom
            attributes.frame = CGRectMake(CGFloat(0), min(bottomOfSection,topOfSection), collectionView!.bounds.width, headerReferenceSize.height)
           
            //float over top cells
            attributes.zIndex = 1
        }
        return attributes
    }
}
