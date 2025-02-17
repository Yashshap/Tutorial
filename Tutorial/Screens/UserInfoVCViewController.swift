//
//  UserInfoVCViewController.swift
//  Tutorial
//
//  Created by Apple on 13/02/25.
//

import UIKit

class UserInfoVCViewController: UIViewController {

    var username: String!
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
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
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVCViewController(user: user), to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user:user), to: self.itemViewTwo)
                    print("Adding GFUserInfoHeaderVC to headerView")

                }
                print(user)
            case .failure(let user):
                self.presentGFAlertOnMainThread(title: "something went wrong", message: "#error.rawValue", buttonTitle: "Ok")
            }
        }
    }
    func layoutUI(){
        
        itemView = [headerView,itemViewOne,itemViewTwo]
        
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
