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
        static let BookCellIdentifier = "BookCell"
        static let ShowContentSegueIdentifier = "ShowChapterContent"
    }
    var books = [Book]()
    var volume = ""
    var volumeID = 1
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
        title = volume
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scripturesVC = segue.destination as? ScripturesViewController  {
            if let indexPath = sender as? IndexPath {
                scripturesVC.bookID = books[indexPath.row].id
                scripturesVC.chapter = 7
            }
        }
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
    
    // MARK: - Tabele View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowContentSegueIdentifier, sender: indexPath)
    }
    
    // MARK: - Helpers
    
    private func updateModel() {
        title = volume
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeID)
    }
}
