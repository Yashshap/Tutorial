//
//  UIHelper.swift
//  Tutorial
//
//  Created by Apple on 10/02/25.
//


import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding = 12
        let minimumItemSpacing = 10
        let availableWidth = Int(width) - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: CGFloat(padding), left: CGFloat(padding), bottom: CGFloat(padding), right: CGFloat(padding))
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
