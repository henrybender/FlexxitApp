//
//  Post.swift
//  SocialMediaPg
//
//  Created by Henry Bender on 11/29/18.
//  Copyright © 2018 Henry Bender. All rights reserved.
//

import Foundation


struct Post: Codable {
    
    var likes: Int
    var id: Int
    var text: String
    var workout: String
    var nickname: String
    
    }
struct PostData: Codable{
    var data: [Post]
}
//struct PostResponse: Codable {
//    var response: PostData
//}
struct PostResponse: Codable {
    var data: Post
}

