//
//  WatchedAnimeController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class WatchedAnimeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    
    var watchedList:[String] = NSUserDefaults.standardUserDefaults().objectForKey("history") as? [String] ?? [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.navigationController?.navigationBarHidden = true;
        makeLayout();
    }
    
    func makeLayout() {
        navBar.setTitleVerticalPositionAdjustment(-5.0, forBarMetrics: UIBarMetrics.Default);
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Bold", size: 28.0)!, NSForegroundColorAttributeName : UIColor(red: CGFloat(0.518), green: CGFloat(0.518), blue: CGFloat(0.518), alpha: CGFloat(1.0))];
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(watchedList);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "info");
        cell.textLabel?.text = watchedList[indexPath.row];
        cell.textLabel?.font = UIFont(name: "Open Sans", size: 20.0);
        return cell;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
