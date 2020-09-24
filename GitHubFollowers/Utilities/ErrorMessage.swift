//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Muhammed on 9/24/20.
//  Copyright © 2020 Muhammed. All rights reserved.
//

import Foundation

enum ErrorMessage: String , Error {
    case invalidUsername = "This username created an invalid request. Please try again "
    case unableToComplete = "Unable to complete you request. Please check your internet connection"
    case invaledResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    
}
