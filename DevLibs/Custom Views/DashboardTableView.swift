//
//  DashboardTableView.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/24/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//
//
//import UIKit
//import CoreData
//
//class DashboardTableView: UITableView, NSFetchedResultsControllerDelegate  {
//
//    let apiController = APIController()
//
//    lazy var fetchResultsController: NSFetchedResultsController<Template> = {
//        let fetchRequest: NSFetchRequest<Template> = Template.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
//        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
//                                             managedObjectContext: CoreDataStack.shared.mainContext,
//                                             sectionNameKeyPath: "id",
//                                             cacheName: nil)
//        frc.delegate = self
//        do {
//            try frc.performFetch()
//        } catch {
//            fatalError("Error performing fetch for frc: \(error)")
//        }
//        return frc
//    }()
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return fetchResultsController.sections?.count ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchResultsController.sections?[section].numberOfObjects ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
//
//        let task = fetchResultsController.object(at: indexPath)
//
//        cell.textLabel?.text = task.name
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        guard let sectionInfo = fetchResultsController.sections?[section] else { return nil }
//
//        return sectionInfo.name.capitalized
//    }
//
//
//}
