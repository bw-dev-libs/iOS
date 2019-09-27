//
//  DashboardViewController.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {
    
    let toStoryView1 = "SegueToStoryView1"
    
    let apiController = APIController()
    
    lazy var fetchResultsController: NSFetchedResultsController<Template> = {
        let fetchRequest: NSFetchRequest<Template> = Template.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataStack.shared.mainContext,
                                             sectionNameKeyPath: "id",
                                             cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        return frc
    }()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
   
    // MARK: - Navigation
    
    @IBAction func unwindToDashboard(_ sender: UIStoryboardSegue) {
    }
    
    @IBAction func addStoryButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: toStoryView1, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toStoryView1 {
            guard let destination = segue.destination as? GameViewController else { return }
            let wordController = WordController()
            destination.wordController = wordController
        }
    }
}

// MARK: - Table view data source

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DevLibCell", for: indexPath) as? DashboardTableViewCell else { return UITableViewCell() }
        
        let template = fetchResultsController.object(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let template = fetchResultsController.object(at: indexPath)
            
            apiController.deleteTemplate(template: template)
        }
    }
}

extension DashboardViewController: UITableViewDelegate {
}

// MARK: - NSFetchedResultsControllerDelegate Methods

extension DashboardViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            return
        }
    }
}
