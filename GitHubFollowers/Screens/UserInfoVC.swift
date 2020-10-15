//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Muhammed on 10/14/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()

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
                DispatchQueue.main.async {
                      self.add(childVC: GFUserInfoVC(user: user), to: self.headerView)
                }
              
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something worng happened", body: error.rawValue, buttonTitle: " OK "   )
            }
        }
        
        layoutUI()
    }
    
    func layoutUI(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
    
    
    
    func add(childVC: UIViewController , to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    
    @objc func dimissVC(){
        dismiss(animated: true)
        
    }
}
