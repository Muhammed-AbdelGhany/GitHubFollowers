//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/27/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    var followerAvatar = GFAvatarImageView(frame: .zero)
    var followerLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set (follower :Follower){
        followerLabel.text = follower.login
        followerAvatar.downloadImage(url: follower.avatarUrl)
    }
    
    
    private func configure(){
        addSubview(followerAvatar)
        addSubview(followerLabel)
        
        NSLayoutConstraint.activate([
            followerAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            followerAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            followerAvatar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            followerAvatar.heightAnchor.constraint(equalTo: followerAvatar.widthAnchor),
            
            followerLabel.topAnchor.constraint(equalTo: followerAvatar.bottomAnchor, constant: 12),
            followerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            followerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            followerLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
