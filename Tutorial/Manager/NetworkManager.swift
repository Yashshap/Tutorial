//
//  NetworkManager.swift
//  Tutorial
//
//  Created by Apple on 05/02/25.
//

import UIKit


 class NetworkManager {
    
     static let shared = NetworkManager()
     private let baseUrl = "https://api.github.com/"
     let cache   = NSCache<NSString, UIImage>()
     private init() {}
     
     func getFollowers(for username: String,page: Int, completed: @escaping (Result<[Follower], GFError>)-> Void){
         
         let endPoint = baseUrl + "users/\(username)/followers?per_page=100&page=\(page)"


         guard let url = URL(string: endPoint) else{
             completed(.failure(.invalidUsername))
             return
         }
         
         let task = URLSession.shared.dataTask(with: url){ data,response,error in
             
             if let _ = error{
                 completed(.failure(.unableToComplete))
             }
             
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                 completed(.failure(.invalidResponse))
                 return
             }
             
             guard let data = data else{
                 completed(.failure(.invalidData))
                 return
             }
//             print("Raw Data:", String(data: data, encoding: .utf8) ?? "Could not decode data")

             do{
                 let decoder = JSONDecoder()
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 let followers = try decoder.decode([Follower].self, from: data)
                 completed(.success(followers))
             }
             catch{
                 
                 completed(.failure(.invalidData))
             }
             
         }
         
         task.resume()
         
     }
    
     func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>)-> Void){
         
         let endPoint = baseUrl + "users/\(username)"


         guard let url = URL(string: endPoint) else{
             completed(.failure(.invalidUsername))
             return
         }
         
         let task = URLSession.shared.dataTask(with: url){ data,response,error in
             
             if let _ = error{
                 completed(.failure(.unableToComplete))
             }
             
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                 completed(.failure(.invalidResponse))
                 return
             }
             
             guard let data = data else{
                 completed(.failure(.invalidData))
                 return
             }
//             print("Raw Data:", String(data: data, encoding: .utf8) ?? "Could not decode data")

             do{
                 let decoder = JSONDecoder()
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 let user = try decoder.decode(User.self, from: data)
                 completed(.success(user))
             }
             catch{
                 
                 completed(.failure(.invalidData))
             }
             
         }
         
         task.resume()
         
     }
    
}
