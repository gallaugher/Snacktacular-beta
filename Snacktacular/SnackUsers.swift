//
//  SnackUsers.swift
//  Snacktacular
//
//  Created by John Gallaugher on 3/7/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class SnackUsers {
    var userArray = [SnackUser]()
    var db: Firestore!
    var storage: Storage!
    
    init() {
        db = Firestore.firestore()
        storage = Storage.storage()
    }

    func loadData(completed: @escaping () -> ()) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return
            }
            self.userArray = []
            for document in querySnapshot!.documents {
                let snackUser = SnackUser(dictionary: document.data())
                self.userArray.append(snackUser)
            }
            completed()
        }
    }

}
