//
//  UserInfoVCViewController.swift
//  Tutorial
//
//  Created by Apple on 13/02/25.
//

import UIKit
import SafariServices


protocol useritemInfoDelegate: class {
    
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
    
}

class UserInfoVCViewController: UIViewController {

    var username: String!
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center)
    var itemView: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
        print(username!)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async{
                    let repoVC = GFRepoItemVCViewController(user: user)
                                    repoVC.delegate = self  // Set the delegate here
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: repoVC, to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user:user), to: self.itemViewTwo)
                    self.dateLabel.text = "\(user.createdAt)"
                }
                print(user)
            case .failure(let user):
                self.presentGFAlertOnMainThread(title: "something went wrong", message: "#error.rawValue", buttonTitle: "Ok")
            }
        }
    }
    
    func configureUiElements(with user:User){
        
        
       
        
    }
    func layoutUI(){
        
        itemView = [headerView,itemViewOne,itemViewTwo,dateLabel]
        
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        for item in itemView {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),            ])
        }
      
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVCViewController: useritemInfoDelegate{
    func didTapGithubProfile(for user: User) {
        print("name2")
        guard let url =  URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
        return
        }
        presentSF(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        
    }
    
    
    
}
