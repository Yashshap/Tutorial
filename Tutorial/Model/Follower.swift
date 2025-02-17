//
//  Follower.swift
//  Tutorial
//
//  Created by Apple on 05/02/25.
//

import Foundation

// when you use codable your variable names have to match the names given in the API DATA OBJECT
struct Follower: Codable , Hashable {    
    var login: String
    var avatarUrl: String
}
