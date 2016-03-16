//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    
    var repos: [GithubRepo] = []
    
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // Perform the search.
    private func doSearch() {

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
//            for repo in newRepos {
//                print(repo)
//            }
            
            self.repos = newRepos
            self.tableView.reloadData()

            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as! RepoCell
        
        cell.nameLable.text = repos[indexPath.row].name
        cell.starCount.text = String(repos[indexPath.row].stars!)
        cell.forkCount.text = String (repos[indexPath.row].forks!)
        cell.descriptionLabel.text = repos[indexPath.row].repoDescription! + repos[indexPath.row].repoDescription!
        cell.ownerLabel.text = repos[indexPath.row].ownerHandle
        
        
        if let profileImageURL = repos[indexPath.row].ownerAvatarURL {
            
            let imageURL = NSURL(string: profileImageURL)
            cell.profileImage.setImageWithURL(imageURL!)
        }
        return cell
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}