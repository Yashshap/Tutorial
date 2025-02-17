//
//  ErrorMessage.swift
//  Tutorial
//
//  Created by Apple on 06/02/25.
//

import Foundation

enum GFError: String,Error {
    
    case invalidUsername  = "This username created an invalid request. Please try again."
    case unableToComplete = "unable to complete your request please check your internet connection."
    case invalidResponse  = "invalid response from the server. Please try again."
    case invalidData      = "The Data received from the server was invalid. Please try again."
    
}
