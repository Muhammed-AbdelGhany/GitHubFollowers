//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/20/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result{
            case .success(let followers) :
            print(followers)
                
            case .failure(let error) :
            self.presentGFAlertOnMainThread(title: "cant get the follower", body: error.rawValue, buttonTitle: "ok")
                           return
            }
                   }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
}
