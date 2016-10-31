//
//  Communicator.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import Foundation
import AFNetworking

protocol CommunicatorDelegate {
    
    func successfullyRetrievedUsersData(data: Data?)
    func retrievingUsersDataFailedWithError(error: Error)
    
    func successfullyRetrievedUserPostsData(data: Data?)
    func retrievingUserPostsDataFailedWithError(error: Error)
}

class Communicator {
    
    // MARK: Properties
    
    static let sharedInstance = Communicator()
    var delegate: CommunicatorDelegate?
    private var manager: AFHTTPSessionManager?
    
    //MARK: Public API
    
    func getUsersData() {
        
        self.manager = createManager()
        
        self.manager!.get(URLs.getUsersListURL(),
                    parameters: nil,
                    progress: nil,
                    success: { (dataTask: URLSessionDataTask, response: Any?) in
                        self.delegate?.successfullyRetrievedUsersData(data: response as? Data)
        
        },
                    failure: { (dataTask: URLSessionDataTask?, error: Error) in
                        self.delegate?.retrievingUsersDataFailedWithError(error: error)
        })
        
    }
    
    
    func getUserPostsData(userId: Int) {
        
        self.manager = createManager()
        
        self.manager!.get(URLs.getUsersPostListURL(userId: userId),
                          parameters: nil,
                          progress: nil,
                          success: { (dataTask: URLSessionDataTask, response: Any?) in
                            self.delegate?.successfullyRetrievedUserPostsData(data: response as? Data)
                            
        },
                          failure: { (dataTask: URLSessionDataTask?, error: Error) in
                            self.delegate?.retrievingUserPostsDataFailedWithError(error: error)
        })
        
    }
    
    // MARK: Private API
    
    private func createManager() -> AFHTTPSessionManager {
        
        if self.manager == nil {
            self.manager = AFHTTPSessionManager()
            self.manager?.responseSerializer = AFHTTPResponseSerializer()
        }
        
        return self.manager!
    }
    
}

