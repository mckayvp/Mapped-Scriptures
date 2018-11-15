//
//  ChaptersViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/13/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class ChaptersViewController : UITableViewController {
  
    private struct Storyboard {
        static let ChapterCellIdentifier = "ChapterCell"
        static let ShowContentSegueIdentifier = "ShowChapterContent"
    }
    
    var book = Book()
    var bookID = 101
    var scriptures = [Scripture]()
    var backName = ""
    var chapter = "Chapter"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateModel()
    }
    
    // MARK: - Segues
    
    // talk to ScripturesViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scripturesVC = segue.destination as? ScripturesViewController  {
            if let indexPath = sender as? IndexPath {
                scripturesVC.bookID = book.id
                scripturesVC.backName = book.citeAbbr
                scripturesVC.chapter = indexPath.row + 1
            }
        }
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return book.numChapters ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ChapterCellIdentifier,
                                                     for: indexPath)

            if(book.parentBookId == 4) {chapter = "Section"}
            cell.textLabel?.text = "\(chapter) \(indexPath.row + 1)"

            return cell
    }
    
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ShowContentSegueIdentifier, sender: indexPath)
    }
    
    
    // MARK: - Helpers
    
    private func updateModel() {
        title = GeoDatabase.sharedGeoDatabase.bookForId(bookID).backName
        book = GeoDatabase.sharedGeoDatabase.bookForId(bookID)
    }
    
}
