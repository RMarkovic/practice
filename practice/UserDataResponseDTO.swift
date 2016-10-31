//
//  UserDataResponseDTO.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import Gloss

struct UserDataResponseDTO: Decodable {
    
    let users: [UserDTO]?
    
    init?(json: JSON) {
        
        self.users = [UserDTO].from(jsonArray: [json])
    }
    
    init?(jsonArray: [JSON]) {
        
        self.users = [UserDTO].from(jsonArray: jsonArray)
    }
}
