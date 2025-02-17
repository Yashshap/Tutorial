//
//  GFItemInfoView.swift
//  Tutorial
//
//  Created by Apple on 16/02/25.
//

import UIKit

class GFItemInfoView: UIView {

    enum itemInfoType{
        case repos,gists,followers,following
    }
    
    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cofigure()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cofigure() {
       
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFit
        symbolImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant:  20),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        
        ])
    }
   
    func set(itemInfoType: itemInfoType, withCount count: Int){
        switch itemInfoType {
            
        case .repos:
            symbolImageView.image = UIImage(systemName: GFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: GFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: GFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: GFSymbols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
        
    }
    }


