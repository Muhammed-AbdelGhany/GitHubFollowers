//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/27/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: "avatar-placeholder")
    }
}
