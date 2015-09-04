//
//  StickyHeaderLayout.swift
//  CollectionViewFun
//
//  Created by Zach McArtor on 3/22/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

import UIKit

class StickyHeaderLayout: UICollectionViewFlowLayout {
  
    let sectionBounds = [Int : UICollectionViewLayoutAttributes]()
   
    override func prepareLayout() {
        collectionView!.numberOfSections()
    }
    
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
        finalFrame.size.height = (bottomY - topY) + headerReferenceSize.height
        
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
            let bottomOfSection = CGRectGetMaxY(sectionFrame) - headerReferenceSize.height - collectionView!.contentInset.bottom
            
            // TODO: when is top going to ever be less then bottom? When bouncing ?
            attributes.frame = CGRect(x: 0, y: min(topOfSection, bottomOfSection), width: collectionView!.bounds.size.width, height: headerReferenceSize.height)
           
            //float over top cells
            attributes.zIndex = 1
        }
        return attributes
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        // Get the layout attributes for a standard UICollectionViewFlowLayout
        var elementsLayoutAttributes = super.layoutAttributesForElementsInRect(rect) as? [UICollectionViewLayoutAttributes]
        if elementsLayoutAttributes == nil {
            return nil
        }
        
        // Define a struct we can use to store optional layout attributes in a dictionary
        struct HeaderAttributes {
            var layoutAttributes: UICollectionViewLayoutAttributes?
        }
        var visibleSectionHeaderLayoutAttributes = [Int : HeaderAttributes]()
        
        
        // Loop through the layout attributes we have
        for (index, layoutAttributes) in enumerate(elementsLayoutAttributes!) {
            let section = layoutAttributes.indexPath.section
            
            switch layoutAttributes.representedElementCategory {
            case .SupplementaryView:
                // If this is a set of layout attributes for a section header, replace them with modified attributes
                if layoutAttributes.representedElementKind == UICollectionElementKindSectionHeader {
                    let newLayoutAttributes = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: layoutAttributes.indexPath)
                    elementsLayoutAttributes![index] = newLayoutAttributes
                    
                    // Store the layout attributes in the dictionary so we know they've been dealt with
                    visibleSectionHeaderLayoutAttributes[section] = HeaderAttributes(layoutAttributes: newLayoutAttributes)
                }
                
            case .Cell:
                // Check if this is a cell for a section we've not dealt with yet
                if visibleSectionHeaderLayoutAttributes[section] == nil {
                    // Stored a struct for this cell's section so we can can fill it out later if needed
                    visibleSectionHeaderLayoutAttributes[section] = HeaderAttributes(layoutAttributes: nil)
                }
                
            case .DecorationView:
                break
            }
        }
        
        // Loop through the sections we've found
        for (section, headerAttributes) in visibleSectionHeaderLayoutAttributes {
            // If the header for this section hasn't been set up, do it now
            if headerAttributes.layoutAttributes == nil {
                let newAttributes = layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: NSIndexPath(forItem: 0, inSection: section))
                elementsLayoutAttributes!.append(newAttributes)
            }
        }
        
        return elementsLayoutAttributes
        }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
