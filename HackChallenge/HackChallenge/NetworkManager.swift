//
//  NetworkManager.swift
//  HackChallenge
//
//  Created by Henry Bender on 12/1/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//

import Foundation
import Alamofire

let endpoint = "http://35.243.243.26/api/posts"
let postEndpoint = "http://35.243.243.26/api/posts/"
//let likeEndpoint = "http://35.243.243.26/api/post/{id}/like/"

class NetworkManager {
    
    static func getPosts(completion: @escaping ([Post]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                print(data)
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let decoder = JSONDecoder()
                if let postData = try? decoder.decode(PostData.self, from: data) {
                    completion(postData.data)
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
    
    static func sharePost(text: String, nickname: String, workout: String, completion: @escaping (PostResponse) -> Void) {
        let parameters: [String: Any] = [
            "text": text,
            "nickname": nickname,
            "workout": workout
        ]
        Alamofire.request(postEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let info = try? decoder.decode(PostResponse.self, from: data) {
                    print(info)
                    completion(info)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func likePost(id: Int) {
        let likePoint = "http://35.243.243.26/api/post/\(id)/like/"
        print(likePoint)
        Alamofire.request(likePoint, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    print(json)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
