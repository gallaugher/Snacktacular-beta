//
//  ViewController.swift
//  Snacktacular
//
//  Created by John Gallaugher on 1/27/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit
import CoreLocation

class SpotListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var spots = [Spot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spots.append(Spot(name: "Shake Shake", address: "The Street - Chestnut Hill", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0))
        spots.append(Spot(name: "El Pelón Taqueria", address: "2197 Commonwealth Ave. Boston, MA", coordinate: CLLocationCoordinate2D(latitude: 42.340252, longitude: -71.16406), averageRating: 0.0, numberOfReviews: 0))
        spots.append(Spot(name: "Cityside Restaurant", address: "Cleveland Circle", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            print("*** ERROR: No identifier in prepare for segue in SpotListViewController")
            return
        }
        switch identifier {
        case "ShowSpot":
            let destination = segue.destination as! SpotDetailViewController
            destination.spot = spots[tableView.indexPathForSelectedRow!.row]
        case "AddSpot":
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        default:
            print("*** ERROR: Unknown identifier in prepare for segue in SpotListViewController")
        }
    }
    
    @IBAction func unwindFromSpotDetailViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "AddNewSpot" {
            let source = segue.source as! SpotDetailViewController
            let newIndexPath = IndexPath(row: spots.count, section: 0)
            spots.append(source.spot)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
}

extension SpotListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = spots[indexPath.row].name
        cell.detailTextLabel?.text = spots[indexPath.row].address
        return cell
    }
}

