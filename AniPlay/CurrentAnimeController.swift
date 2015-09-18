//
//  CurrentAnimeController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class CurrentAnimeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentAnimeList:[String] = [];
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.navigationController?.navigationBarHidden = true;
        makeLayout();
        
        let url = NSURL(string: "http://pranavh.webfactional.com/aniplay/airinganimelist.php");
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            if error != nil {
                print(error);
            } else {
                let jsonresult = JSON(data: data!);
                for (key, subJson): (String, JSON) in jsonresult {
                    var num: Int = (key as NSString).integerValue;
                    self.currentAnimeList.append(subJson[0].description);
                }
                //remove all current anime i don't have data for D;
                var finallist:[String] = [];
                for(var i = 0; i < self.currentAnimeList.count; i++) {
                    if AnimeData.animeidsreverse[self.currentAnimeList[i]] != nil {
                        finallist.append(self.currentAnimeList[i]);
                    }
                }
                self.currentAnimeList = finallist;
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData();
                })
            }
        }
        task.resume();
    }
    
    func makeLayout() {
        navBar.setTitleVerticalPositionAdjustment(-5.0, forBarMetrics: UIBarMetrics.Default);
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Bold", size: 28.0)!, NSForegroundColorAttributeName : UIColor(red: CGFloat(0.518), green: CGFloat(0.518), blue: CGFloat(0.518), alpha: CGFloat(1.0))];
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimeList.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showAnimeCurrent", sender: self.tableView.cellForRowAtIndexPath(indexPath));
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var curanime = "";
        if segue.identifier == "showAnimeCurrent" {
            if ((sender?.isKindOfClass(UITableViewCell)) != nil) {
                curanime = sender?.textLabel?!.text as String!;
            }
            let destVC: AnimeViewController = segue.destinationViewController as! AnimeViewController;
            destVC.animeName = curanime;
        }
    }
    
    // defines contents of each indiv. cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // identifier ids cell
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        // indexpath tells you row
        cell.textLabel?.text = currentAnimeList[indexPath.row];
        cell.textLabel?.font = UIFont(name: "Open Sans", size: 20.0);
        return cell;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
