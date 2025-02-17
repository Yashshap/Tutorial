//
//  GFUserInfoHeaderVC.swift
//  Tutorial
//
//  Created by Apple on 15/02/25.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    
    let avatarImageView   = GFAvtarImageView(frame: .zero)
    let userNameLabel     = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel         = GFSeconsaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel     = GFSeconsaryTitleLabel(fontSize: 18)
    let bio               = GFBodyLabel(textAlignment: .left)

    
    var user: user!
    
    init(user: user!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layoutUI()
        configureUiElements()
        // Do any additional setup after loading the view.
        print("GFUserInfoHeaderVC loaded successfully")

    }
    

    func addSubView(){
        view.addSubview(avatarImageView)
        view.addSubview(userNameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bio)

    }
    
    func configureUiElements(){
        
        avatarImageView.downloadImage(from: user.avatarUrl)
        userNameLabel.text          = user.login
        nameLabel.text              = user.name ?? "User"
        locationLabel.text          = user.location ?? "No Location"
        bio.text                    = user.bio ?? "No Bio"
        bio.numberOfLines           = 3
        locationImageView.image     = UIImage(systemName: GFSymbols.location)
        locationImageView.tintColor = .secondaryLabel

    }
    func layoutUI(){
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor), // ✅ Align with avatarImageView bottom
               locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8), // ✅ Position beside avatarImageView
               locationImageView.heightAnchor.constraint(equalToConstant: 20),
               locationImageView.widthAnchor.constraint(equalToConstant: 20),
               
               locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
               locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor), // ✅ Position beside locationImageView
               locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bio.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bio.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bio.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bio.heightAnchor.constraint(equalToConstant: 60)


        ])
    }

}
