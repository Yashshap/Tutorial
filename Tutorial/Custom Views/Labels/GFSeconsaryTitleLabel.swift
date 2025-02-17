//
//  GFSeconsaryTitleLabel.swift
//  Tutorial
//
//  Created by Apple on 15/02/25.
//

import UIKit

class GFSeconsaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("is not implemented")
    }
    
    init(fontSize: CGFloat){
        super.init(frame: .zero)
        UIFont.systemFont(ofSize: fontSize, weight: .medium)
        
        configure()
    }
    
    private func configure(){
        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
