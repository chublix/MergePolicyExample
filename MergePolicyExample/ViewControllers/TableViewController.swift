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
    
    private lazy var container = AppDelegate.appDelegate.persistentContainer

    private lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        try? controller.performFetch()
        return controller
    }()
    
    private lazy var editActions = [
        UITableViewRowAction(style: .normal, title: "Edit", handler: { [weak self] (_, indexPath) in
            self?.editAction(indexPath: indexPath)
        }),
        UITableViewRowAction(style: .destructive, title: "Delete", handler: { [weak self] (_, indexPath) in
            self?.deleteAction(indexPath: indexPath)
        })
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let refreshView = RefreshView.create()
        refreshView.delegate = self
        refreshControl = refreshView
    }
    
    private func load(name: String) {
        let data = NSDataAsset(name: name)!.data
        container.performBackgroundTask { (context) in
            context.mergePolicy = MergePolicy.create()
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.context!] = context
            do {
                _ = try decoder.decode([Item].self, from: data)
                try context.save()
            } catch { }
        }
    }
    
    private func editAction(indexPath: IndexPath) {
        guard let objectID = fetchedResultsController.fetchedObjects?[indexPath.row].objectID else { return }
        let context = container.newBackgroundContext()
        guard let object = try? context.existingObject(with: objectID) as? Item else { return }
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = object?.name
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Info"
            textField.text = object?.info
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            context.performAndWait {
                object?.name = alert.textFields?.first?.text
                object?.info = alert.textFields?.last?.text
                try? context.save()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteAction(indexPath: IndexPath) {
        guard let objectID = fetchedResultsController.fetchedObjects?[indexPath.row].objectID else { return }
        let context = container.newBackgroundContext()
        guard let object = try? context.existingObject(with: objectID) else { return }
        
        let alert = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            context.perform {
                context.delete(object)
                try? context.save()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SubitemsTableViewController {
            vc.subitems = (sender as? Item)?.subitems?.allObjects as? [Subitem]
        }
    }

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.fetchedObjects?[indexPath.row]
        performSegue(withIdentifier: "subitems", sender: item)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return editActions
    }
    
}


//MARK:- custom refresh control delegate method
extension TableViewController: RefreshViewDelegate {
    
    func refreshView(_ view: RefreshView, buttonDidTouch type: RefreshButtonType) {
        switch type {
            case .setup: load(name: "setup")
            case .update: load(name: "update")
            default: break
        }
        view.endRefreshing()
    }
    
}


//MARK:- FetchedResultsController delegate methods
extension TableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}

