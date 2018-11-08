//
//  BooksViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/7/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class BooksViewController : UITableViewController {
    
    private struct Storyboard {
//        static let ShowBooksSegueIdentifier = "ShowBooks"
        static let BookCellIdentifier = "BookCell"
    }
    var books = GeoDatabase.sharedGeoDatabase.booksForParentId(1)
    var volume = ""
    var volumeID = 1
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeID)
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.BookCellIdentifier,
                                                 for: indexPath)
            
        cell.textLabel?.text = books[indexPath.row].fullName
            
        return cell
    }
}
