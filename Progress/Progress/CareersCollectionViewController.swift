//
//  CareersCollectionViewController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/21/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit
import CoreData

class CareersCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Properties
    
    let careerController = CareerController()
    fileprivate var selectedCareer: Career?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Career> = {
        let fetchRequest: NSFetchRequest<Career> = Career.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "completed", cacheName: nil)
        frc.delegate = self
        try! frc.performFetch()
        return frc
    }()
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CareerCell", for: indexPath) as? CareerCollectionViewCell else { return UICollectionViewCell() }
        let career = fetchedResultsController.object(at: indexPath)
        cell.careerLabel.numberOfLines = 0
        cell.careerLabel.lineBreakMode = .byWordWrapping
        cell.layer.cornerRadius = 25.0
        cell.layer.borderWidth = 3.0
        cell.layer.borderColor = ThemeHelper.lambdaLightBlue.cgColor
        cell.careerLabel.text = career.name
        if career.completed == true {
            cell.completedLabel.text = "Completed ✅"
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let career = fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
        self.selectedCareer = career
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            DispatchQueue.main.async {
                self.collectionView!.numberOfItems(inSection: 0)
                self.collectionView.insertItems(at: [newIndexPath!])
            }
            break

        case .delete:
            DispatchQueue.main.async {
                self.collectionView!.numberOfItems(inSection: 0)
                self.collectionView.deleteItems(at: [indexPath!])
            }
            break
        case .update:
            DispatchQueue.main.async {
                self.collectionView!.numberOfItems(inSection: 0)
                self.collectionView.reloadItems(at: [indexPath!])
            }
            break
        case .move:
            DispatchQueue.main.async {
                self.collectionView!.numberOfItems(inSection: 0)
                self.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
            }
        @unknown default:
            fatalError()
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        print ("section info changed in fecthed controller")
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            self.collectionView!.numberOfItems(inSection: 0)
            collectionView.insertSections(indexSet)
            break
        case .delete:
            self.collectionView!.numberOfItems(inSection: 0)
            collectionView.deleteSections(indexSet)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        @unknown default:
            fatalError()
        }
    }
    
    func controllerWillChangeContent(_ controller:
    NSFetchedResultsController<NSFetchRequestResult>) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCareer" {
            guard let destinationVC = segue.destination as? CareerDetailViewController else { return }
            destinationVC.career = selectedCareer
            destinationVC.careerController = careerController
        }
    }

}

