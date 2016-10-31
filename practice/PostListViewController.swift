//
//  PostListViewController.swift
//  practice
//
//  Created by Radoljub Markovic on 10/31/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WSManagerDelegate {
    
    // MARK: Properties
    
    private struct PostListViewControllerConstants {
        static let estimatedRowHeight: CGFloat = 110.0
        static let cellIdentifier = "PostListTableViewCell"
        static let title = "Posts"
    }

    @IBOutlet weak var tableView: UITableView!
    
    var userId: Int?
    private var posts: [UserPostDTO]?
    private let wsManager = WSManager.sharedInstance
    
    // MARK: Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.wsManager.delegate = self
        getUserPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    
    private func configureUI() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = PostListViewControllerConstants.estimatedRowHeight
        self.navigationItem.title = PostListViewControllerConstants.title
    }
    
    func getUserPosts() {
        
        if userId != nil {
            self.wsManager.getUserPostsList(userId: userId!)
        }
    }
    
    // MARK: Public API
    
    static func createPostListViewController() -> PostListViewController {
        
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "PostListViewController") as! PostListViewController
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts != nil ? posts!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListViewControllerConstants.cellIdentifier, for: indexPath) as! PostListTableViewCell
        
        let post = posts![indexPath.row]
        
        cell.title.text = post.title
        cell.body.text = post.body
        
        return cell
    }
    
    // MARK: WSManagerDelegate
    
    func successfullyRetrievedUserPosts(posts: [UserPostDTO]) {
        
        self.posts = posts
        self.tableView.reloadData()
    }
    
    func retrievingUserPostsFailedWithError(error: Error) {
        let alertController = UIUtils.createErrorAlertDialog(error: error)
        present(alertController, animated: true, completion: nil)
    }
}
