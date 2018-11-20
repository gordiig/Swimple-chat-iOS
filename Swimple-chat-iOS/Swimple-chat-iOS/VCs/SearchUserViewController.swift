//
//  SearchUserViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 20/11/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SearchUserViewController: MyViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var usersTableView: UITableView!
    var foundUsers: [String] = ["New user"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return foundUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchedUserTableViewCell") else
        {
            alert(title: "Table view error", message: "Can't dequeue cell for table view")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = foundUsers[row]
        return cell
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let idx = usersTableView.indexPathForSelectedRow?.row ?? 0
        
        guard let destVC = segue.destination as? ChatViewController else
        {
            alert(title: "Segue error", message: "Can't get destination VC")
            return
        }
        
        let user = User(username: foundUsers[idx])
        let room = ChatRooms.default.getRoom(for: user, createIfNone: true)!
        destVC.user = user
        destVC.room = room
    }
    
}
