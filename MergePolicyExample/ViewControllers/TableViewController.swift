//
//  TableViewController.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    private lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = []
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        return controller
    }()

}

//MARK:- TableView dataSource methods override
extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
}

//MARK:- TableView delegate methods override
extension TableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.fetchedObjects?[indexPath.row]
        cell.textLabel?.text = item?.name
        cell.detailTextLabel?.text = item?.info
    }
    
}

//MARK:- FetchedResultsController delegate methods
extension TableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
