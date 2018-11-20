//
//  SearchUserViewController.swift
//  Swimple-chat-iOS
//
//  Created by Dmitry Gorin on 20/11/2018.
//  Copyright © 2018 gordiig. All rights reserved.
//

import UIKit

class SearchUserViewController: MyViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate
{
    @IBOutlet weak var usersTableView: UITableView!
    var foundUsers: [String] = ["New user"]
    {
        didSet(newVal) { filterUsers() }
    }
    var filteredUsers: [String] = []
    {
        didSet(newVal) { usersTableView.reloadData() }
    }
    let refreshControl = UIRefreshControl()
    let searchBar = UISearchBar()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged), for: .valueChanged)
        
        searchBar.placeholder = "Search users..."
        navigationItem.titleView = searchBar
        
        filterUsers()

        searchBar.delegate = self
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.refreshControl = refreshControl
        usersTableView.keyboardDismissMode = .interactive
    }
    
    
    // MARK: - Refresh control
    @objc func refreshControlValueChanged(_ sender: Any?)
    {
        loadUsers()
        self.refreshControl.endRefreshing()
    }
    func loadUsers()
    {
        // TODO
    }
    
    
    // MARK: - UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.text = ""
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        self.filterUsers()
    }
    func filterUsers()
    {
        guard var filter = self.searchBar.text else { filteredUsers = foundUsers; return }
        
        filter = filter.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if filter.isEmpty { filteredUsers = foundUsers; return }
        filteredUsers = foundUsers.filter({ user -> Bool in
            user.lowercased().range(of: filter.lowercased()) != nil
        })
    }
    
    
    // MARK: - UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchedUserTableViewCell") else
        {
            alert(title: "Table view error", message: "Can't dequeue cell for table view")
            return UITableViewCell()
        }
        
        cell.textLabel?.text = filteredUsers[row]
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
