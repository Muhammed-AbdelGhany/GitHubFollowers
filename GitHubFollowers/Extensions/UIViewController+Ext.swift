//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController{
    
    func presentGFAlertOnMainThread (title :String , body: String , buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, body: body, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView (){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dimissLoadinView (){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView (message: String , view :UIView){
        let emptyView = GFEmptyStateView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
}
