//
//  GFItemInfoVC.swift
//  Tutorial
//
//  Created by Apple on 17/02/25.
//

import UIKit

class GFItemInfoVC: ViewController {

   
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton    = GFButton()
    
    var user: User!
    weak var delegate: useritemInfoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureBackgroundView()
        configureStackView()
        configureActionButton()
    }
    
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private  func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)

    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
   @objc func actionButtonTapped(){}
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    

    

}
