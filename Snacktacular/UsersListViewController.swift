//
//  UsersListViewController.swift
//  Snacktacular
//
//  Created by John Gallaugher on 3/7/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit
import Firebase

class UsersListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users = SnackUsers()
    var db = Firestore.firestore()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        users.loadData {
            self.tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "ShowSnackUser" {
            let destination = segue.destination as! UserProfileViewController
            destination.snackUser = users.userArray[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserListTableViewCell
        cell.user = users.userArray[indexPath.row]
        return cell
    }
}
