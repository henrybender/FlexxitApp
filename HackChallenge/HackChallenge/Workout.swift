//
//  Workout.swift
//  MusicFit
//
//  Created by Emily Reynolds on 11/27/18.
//  Copyright © 2018 Emily Reynolds. All rights reserved.
//
import Foundation

class Workout {
    
    var imageName: String!
    var name: String!
    var type: [String]!
    var description: String!
    
    init(imageName: String, name: String, type:[String], description: String) {
        self.imageName = imageName
        self.name = name
        self.type = type
        self.description = description
    }
    
}
