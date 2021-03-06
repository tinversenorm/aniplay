//
//  EpisodeViewController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/31/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var animeName: String = "";
    var episodeList: [String] = [];
    var episodeLinks = Dictionary<String, String>();
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func unwindToEpisodeList(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        makeLayout();
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "unwind:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.view.addGestureRecognizer(swipeRight);
        
        // Load episode list
        let dbname = AnimeData.animeidsreverse[animeName]! + "E";
        //http://pranavh.webfactional.com/aniplay/episodedbtojson.php?table=10E
        // ^ example
        //dispatch_async(dispatch_get_main_queue(), { () -> Void in
        let url = NSURL(string: "http://pranavh.webfactional.com/aniplay/episodedbtojson.php?table=" + dbname);
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if error != nil {
                print(error);
            } else {
                let jsonresult = JSON(data: data!);
                for (key, subJson): (String, JSON) in jsonresult {
                    var num: Int = (key as NSString).integerValue;
                    self.episodeLinks[key] = subJson["eplink"].string!;
                    self.episodeList.append(subJson["eplink"].string!);
                    print("")
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData();
                });
            }
        }
        task.resume();
        //});
    }
    
    func unwind(gesture: UIGestureRecognizer) {
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("unwindToAnime", sender: self);
        });
    }
    
    func makeLayout() {
        titleLabel.text = animeName;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "episode")
        //println(String(indexPath.row));
        _ = self.episodeLinks[String(indexPath.row)]?.substringFrom(15);
        cell.textLabel?.text = "Episode " + String(episodeLinks.count-indexPath.row);
        cell.textLabel?.font = UIFont(name: "Open Sans", size: 20.0);
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("watchSegue", sender: self.tableView.cellForRowAtIndexPath(indexPath));
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "watchSegue" {
            _ = "";
            let path = self.tableView.indexPathForSelectedRow!
            let destVC:WatchViewController = segue.destinationViewController as! WatchViewController;
            destVC.link = self.episodeList[path.row];
            destVC.animeName = self.animeName;
            destVC.episodeNumber = String(path.row+1);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}
