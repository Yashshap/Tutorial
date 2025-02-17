//
//  GFButton.swift
//  Tutorial
//
//  Created by Apple on 01/02/25.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("has not implemented")
    }
    
    required init(backgroundColor: UIColor, title:String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        
        layer.cornerRadius    = 10
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor,title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        
    }

}
