



import UIKit



class GFFollowerItemVC: GFItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
        
    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }
}


//
//  GFFollowerItemVC.swift
//  Tutorial
//
//  Created by Apple on 17/02/25.
//

