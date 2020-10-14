//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Muhammed on 10/14/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(username!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dimissVC))
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result{
            case.success(let user):
                print(user)
                
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something worng happened", body: error.rawValue, buttonTitle: " OK "   )
            }
        }
    }
    
    @objc func dimissVC(){
        dismiss(animated: true)
        
    }
}
