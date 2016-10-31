//
//  UserPostDTO.swift
//  practice
//
//  Created by Radoljub Markovic on 10/31/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import Gloss

struct UserPostDTO: Decodable {
    
    let userId: Int?
    let postId: Int?
    let title: String?
    let body: String?
    
    init?(json: JSON) {
        
        self.userId = "userId" <~~ json
        self.postId = "id" <~~ json
        self.title = "title" <~~ json
        self.body = "body" <~~ json
    }
    
}
