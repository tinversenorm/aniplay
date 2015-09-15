//
//  AllAnimeController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//
// 9/13/15 -- Search works but can change tabs with active search controller

import UIKit

class AllAnimeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView();
    
    
    let letters = NSCharacterSet.letterCharacterSet()
    var alphabet = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    
    @IBAction func unwindToAll(segue: UIStoryboardSegue) {
    }
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBarHidden = true;
        tableView.delegate = self;
        tableView.dataSource = self;
        resultSearchController.delegate = self;
        makeLayout();
        
        filteredTableData = AnimeData.nameList;
        
        resultSearchController = UISearchController(searchResultsController: nil);
        resultSearchController.searchResultsUpdater = self;
        resultSearchController.dimsBackgroundDuringPresentation = false;
        resultSearchController.searchBar.sizeToFit();
        tableView.tableHeaderView = resultSearchController.searchBar;
        definesPresentationContext = true;
    }
    
    func makeLayout() {
        navBar.setTitleVerticalPositionAdjustment(-5.0, forBarMetrics: UIBarMetrics.Default);
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Bold", size: 28.0)!, NSForegroundColorAttributeName : UIColor(red: CGFloat(0.518), green: CGFloat(0.518), blue: CGFloat(0.518), alpha: CGFloat(1.0))];
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        if self.resultSearchController.active {
            return 1;
        } else {
            return 27;
        }
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        if self.resultSearchController.active {
            return nil;
        } else {
            return alphabet;
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.resultSearchController.active {
            return "Results";
        } else {
            return alphabet[section];
        }
    }
    
    // num Rows in table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionLetter = alphabet[section];
        if self.resultSearchController.active {
            return self.filteredTableData.count;
        } else {
            return count(AnimeData.animelist[sectionLetter]!);
        }
    }
    
    
    // defines contents of each indiv. cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // identifier ids cell
        let cell = tableView.dequeueReusableCellWithIdentifier("anime_all") as! UITableViewCell;
        // indexpath tells you row
        var sect = alphabet[indexPath.section]; // letter
        if self.resultSearchController.active {
            var name: String = self.filteredTableData[indexPath.row];
            cell.textLabel?.text = name;
        } else {
            cell.textLabel?.text = AnimeData.animeids[AnimeData.animelist[sect]![indexPath.row]];
        }
        cell.textLabel?.font = UIFont(name: "Open Sans", size: 20.0);
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var curanime = "";
        if segue.identifier == "showAnime" {
            if ((sender?.isKindOfClass(UITableViewCell))!) {
                curanime = sender?.textLabel?!.text as String!;
            }
            curanime = sender as! String;
            var destVC: AnimeViewController = segue.destinationViewController as! AnimeViewController;
            destVC.animeName = curanime;
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.resultSearchController.active = false
            self.performSegueWithIdentifier("showAnime", sender: self.filteredTableData[indexPath.row]);
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        filteredTableData = searchText.isEmpty ? AnimeData.nameList : AnimeData.nameList.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        
        tableView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
