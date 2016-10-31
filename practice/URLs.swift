//
//  URLs.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation

class URLs {
    
    private static let BASE_URL = "https://jsonplaceholder.typicode.com/"
    private static let USERS_URL = "users"
    private static let USER_POSTS_URL = "posts?userId="
    
    static func getUsersListURL() -> String {
        return BASE_URL + USERS_URL
    }
    
    static func getUsersPostListURL(userId: Int) -> String {
        return BASE_URL + USER_POSTS_URL + String(userId)
    }
}
