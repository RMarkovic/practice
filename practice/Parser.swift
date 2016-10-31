//
//  Parser.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import Gloss

class Parser {
    
    // MARK: Public API
    
    static func parseUsersListData(data: Data) -> Any? {
        
        do {
            let json = try JSONArrayFromData(data: data)
            
            guard json != nil,
                let usersResponse = UserDataResponseDTO(jsonArray: json!),
                let users = usersResponse.users else {
                return createParseError()
            }
            
            return users
            
        } catch {
            print("Error serializing JSON: \(error)")
            return error
        }
    }
    
    static func parseUserPostsListData(data: Data) -> Any? {
        
        do {
            let json = try JSONArrayFromData(data: data)
            
            guard json != nil,
                let usersResponse = UserPostsResponseDTO(jsonArray: json!),
                let posts = usersResponse.posts else {
                    return createParseError()
            }
            
            return posts
            
        } catch {
            print("Error serializing JSON: \(error)")
            return error
        }
    }
    
    // MARK: Private API
    
    private static func JSONArrayFromData(data : Data) throws -> [[String : AnyObject]]? {
        
        var json: [[String : AnyObject]]?
        
        do {
            json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions()) as? [[String: AnyObject]]
            
        } 
        
        return json as [[String : AnyObject]]?
    }
    
    private static func createParseError() -> NSError {
        
        let errorInfo = [NSLocalizedDescriptionKey : "Bad response from server", "STATUS": 303] as [String : Any]
        return NSError(domain: "HTTPResponseErrorDomain", code: 303, userInfo: errorInfo as [NSObject : AnyObject])
    }
        
}
