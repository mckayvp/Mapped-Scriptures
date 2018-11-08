//
//  VolumesViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/7/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class VolumesViewController : UITableViewController {
    
    private struct Storyboard {
        static let ShowBooksSegueIdentifier = "ShowBooks"
        static let VolumeCellIdentifier = "VolumeCell"
    }
    var model = GeoDatabase.sharedGeoDatabase.volumes()
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Communicate the model over to its destination view controller
    }
    
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.VolumeCellIdentifier, for: indexPath)
            
        cell.textLabel?.text = model[indexPath.row]
            
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowBooksSegueIdentifier,
                     sender: model[indexPath.row])
    }
}
