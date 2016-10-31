//
//  UserPostsResponseDTO.swift
//  practice
//
//  Created by Radoljub Markovic on 10/31/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import Gloss

struct UserPostsResponseDTO: Decodable {
    
    let posts: [UserPostDTO]?
    
    init?(json: JSON) {
        self.posts = [UserPostDTO].from(jsonArray: [json])
    }
    
    init?(jsonArray: [JSON]) {
        self.posts = [UserPostDTO].from(jsonArray: jsonArray)
    }
}
