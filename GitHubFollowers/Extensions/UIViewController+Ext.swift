//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/21/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func presentGFAlertOnMainThread (title :String , body: String , buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, body: body, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
