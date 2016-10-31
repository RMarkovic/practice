//
//  UserDTO.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import Gloss

struct UserDTO: Decodable {
    
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: AddressDTO?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.username = "username" <~~ json
        self.email = "email" <~~ json
        self.address = "address" <~~ json
    }
    
}
