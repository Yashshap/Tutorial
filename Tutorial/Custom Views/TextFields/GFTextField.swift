//
//  GFTextField.swift
//  Tutorial
//
//  Created by Apple on 01/02/25.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not implemented")
    }
    
    
    
    private func configure(){
        
        layer.cornerRadius = 10
        layer.borderWidth  = 2
        layer.borderColor  = UIColor.systemGray.cgColor
        
        textColor          = .label
        tintColor          = .label
        textAlignment      = .center
        minimumFontSize    = 12
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        
        backgroundColor    = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType      = .go
        placeholder        = "Enter a user name "
        
        
        translatesAutoresizingMaskIntoConstraints = false

    }
}
