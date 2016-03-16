//
//  RepoCell.swift
//  GithubDemo
//
//  Created by hvmark on 3/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var forkCount: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    var repo: GithubRepo!

}
