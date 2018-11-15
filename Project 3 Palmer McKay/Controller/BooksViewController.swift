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
        static let ShowChaptersSegueIdentifier = "ShowChapterList"
        static let ShowContentSegueIdentifier = "ShowChapterContent"
    }
    var books = [Book]()
    var volume = ""
    var volumeAbbr = ""
    var volumeID = 1
    var numChapters = 0
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
    }
    
    // MARK: - Segues
    
    // talk to ChaptersViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Communicate the model over to its destination view controller
        if segue.identifier == Storyboard.ShowChaptersSegueIdentifier {
            if let chaptersVC = segue.destination as? ChaptersViewController {
                if let indexPath = sender as? IndexPath {
                    chaptersVC.bookID = books[indexPath.row].id
                    chaptersVC.backName = books[indexPath.row].backName
                    
                }
            }
        }
        else if segue.identifier == Storyboard.ShowContentSegueIdentifier {
            if let scripturesVC = segue.destination as? ScripturesViewController {
                if let indexPath = sender as? IndexPath {
                    scripturesVC.bookID = books[indexPath.row].id
                    scripturesVC.chapter = books[indexPath.row].numChapters ?? 0
                    scripturesVC.backName = books[indexPath.row].backName
                }
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
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        numChapters = books[indexPath.row].numChapters ?? 0
        if numChapters < 2 { // go straight to content
            performSegue(withIdentifier: Storyboard.ShowContentSegueIdentifier, sender: indexPath)
        } else {
            performSegue(withIdentifier: Storyboard.ShowChaptersSegueIdentifier, sender: indexPath)
        }
        
    }
    
    
    // MARK: - Helpers
    
    private func updateModel() {
        title = volumeAbbr
        books = GeoDatabase.sharedGeoDatabase.booksForParentId(volumeID)
    }
}
