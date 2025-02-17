//
//  GFRepoItemVCViewController.swift
//  Tutorial
//
//  Created by Apple on 17/02/25.
//

import UIKit

class GFRepoItemVCViewController: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()

    }
    
    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    

    

}
