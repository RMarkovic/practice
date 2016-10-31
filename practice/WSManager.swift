//
//  WSManager.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation

protocol WSManagerDelegate {
    
    func successfullyRetrievedUsersData(users: [UserDTO])
    func retrievingUsersDataFailedWithError(error: Error)
    
    func successfullyRetrievedUserPosts(posts: [UserPostDTO])
    func retrievingUserPostsFailedWithError(error: Error)
}

extension WSManagerDelegate {
    
    func successfullyRetrievedUsersData(users: [UserDTO]) {}
    func retrievingUsersDataFailedWithError(error: Error) {}
    
    func successfullyRetrievedUserPosts(posts: [UserPostDTO]) {}
    func retrievingUserPostsFailedWithError(error: Error) {}
}

class WSManager: CommunicatorDelegate {
    
    // MARK: Properties
    
    static let sharedInstance = WSManager()
    var delegate: WSManagerDelegate?
    private let communicator: Communicator
    
    // MARK: Init
    
    init() {
        self.communicator = Communicator.sharedInstance
        self.communicator.delegate = self
    }
    
    // MARK: Public API
    
    func getUsersList() {
        self.communicator.getUsersData()
    }
    
    func getUserPostsList(userId: Int) {
        self.communicator.getUserPostsData(userId: userId)
    }
    
    // MARK: CommunicatorDelegate
    
    func successfullyRetrievedUsersData(data: Data?) {
        
        let usersResponse = Parser.parseUsersListData(data: data!)
        
        if let users = usersResponse as? [UserDTO] {
             self.delegate?.successfullyRetrievedUsersData(users: users)
        } else if let error = usersResponse as? Error  {
            self.delegate?.retrievingUsersDataFailedWithError(error: error)
        }
        
    }
    
    func retrievingUsersDataFailedWithError(error: Error) {
         self.delegate?.retrievingUsersDataFailedWithError(error: error)
    }
    
    func successfullyRetrievedUserPostsData(data: Data?) {
        
        let userPostsResponse = Parser.parseUserPostsListData(data: data!)
        
        if let posts = userPostsResponse as? [UserPostDTO] {
            self.delegate?.successfullyRetrievedUserPosts(posts: posts)
        } else if let error = userPostsResponse as? Error  {
            self.delegate?.retrievingUserPostsFailedWithError(error: error)
        }
    }
    
    func retrievingUserPostsDataFailedWithError(error: Error){
        self.delegate?.retrievingUserPostsFailedWithError(error: error)
    }
}
