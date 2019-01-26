//
//  SubitemsTableViewController.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/26/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

class SubitemsTableViewController: UITableViewController {

    var subitems: [Subitem]! = [] {
        didSet {
            tableView.reloadData()
        }
    }

    
}


extension SubitemsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subitems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
}


extension SubitemsTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = subitems[indexPath.row].name
    }
    
}
