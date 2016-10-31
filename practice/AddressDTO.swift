//
//  AddressDTO.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import Gloss

struct AddressDTO: Decodable {

    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    
    init?(json: JSON) {
        self.street = "street" <~~ json
        self.suite = "suite" <~~ json
        self.city = "city" <~~ json
        self.zipcode = "zipcode" <~~ json
    }
}
