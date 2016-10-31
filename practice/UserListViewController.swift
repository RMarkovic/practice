//
//  UserListViewController.swift
//  practice
//
//  Created by Radoljub Markovic on 10/28/16.
//  Copyright © 2016 Radoljub Markovic. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WSManagerDelegate {
    
    // MARK: Properties
    
    private struct UserListViewControllerConstants {
        static let estimatedRowHeight: CGFloat = 110.0
        static let cellIdentifier = "UserListTableViewCell"
        static let title = "Users"
    }

    @IBOutlet weak var tableView: UITableView!
    
    private var users: [UserDTO]?
    private let wsManager = WSManager.sharedInstance
    
    // MARK: LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.wsManager.delegate = self
        getUsersData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    
    private func getUsersData() {
        self.wsManager.getUsersList()
    }
    
    private func configureUI() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = UserListViewControllerConstants.estimatedRowHeight
        self.navigationItem.title = UserListViewControllerConstants.title
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users != nil ? users!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListViewControllerConstants.cellIdentifier, for: indexPath) as! UserListTableViewCell
        
        let user = users![indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.emailLabel.text = user.email
        
        guard let address = user.address,
        let street = address.street,
        let suite = address.suite,
        let city = address.city,
        let zipCode = address.zipcode else {
            cell.addressLabel.text = nil
            return cell
        }
        
        cell.addressLabel.text = street + ", " + suite + ", " + city + ", " + zipCode
     
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedUser = users?[indexPath.row] {
            
            let postListVC = PostListViewController.createPostListViewController()
            postListVC.userId = selectedUser.id
            self.navigationController?.pushViewController(postListVC, animated: true)
        }
    }
    
    // MARK: WSManagerDelegate
    
    func successfullyRetrievedUsersData(users: [UserDTO]) {
        self.users = users
        self.tableView.reloadData()
    }
    
    func retrievingUsersDataFailedWithError(error: Error) {
        let alertController = UIUtils.createErrorAlertDialog(error: error)
        present(alertController, animated: true, completion: nil)
    }
}
