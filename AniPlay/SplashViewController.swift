//
//  SplashViewController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/18/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

struct AnimeData {
    static var animelist = Dictionary<String, [String]>(); // Letter -> ID
    static var animeinfo = Dictionary<String, [String:String]>(); // ID -> DB Info
    static var animeids = Dictionary<String, String>(); // ID -> Anime
    static var animeidsreverse = Dictionary<String, String>(); // Anime name -> ID
}

class SplashViewController: UIViewController {
    
    var alphabet = ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    
    
    override func loadView() {
        for alpha in alphabet {
            AnimeData.animelist[alpha] = Array<String>();
        }
        super.loadView();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        var segueName = "startAppFirst";
        var isFirstTime: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("firstUse");
        if isFirstTime != nil {
            segueName = "startAppRegular";
        } else {
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "firstUse");
        }
        /*
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50));
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray;
        view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
        UIApplication.sharedApplication().beginIgnoringInteractionEvents();*/
        let letters = NSCharacterSet.letterCharacterSet();
        let url = NSURL(string: "http://pranavh.webfactional.com/aniplay/animedbtojson.php");
        let session = NSURLSession.sharedSession();
        let task = session.dataTaskWithURL(url!, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error);
            } else {
                //println(NSString(data: data, encoding: NSUTF8StringEncoding));
                // takes json string and converts
                let jsonresult = JSON(data: data);
                //println(jsonresult);
                var count = 0;
                for (key: String, subJson: JSON) in jsonresult {
                    //Do something you want
                    //subJson["name"].string!
                    var id = key.substringFrom(5);
                    
                    // store in name list
                    var name:String = subJson["name"].string!;
                    var firstletter:String = name.substringTo(1);
                    //println(firstletter);
                    for letter in firstletter.unicodeScalars {
                        if letters.longCharacterIsMember(letter.value) {
                            AnimeData.animelist[firstletter]?.append(id);
                        } else {
                            AnimeData.animelist["#"]?.append(id);
                        }
                    }
                    
                    // store in id list
                    
                    AnimeData.animeids[id] = subJson["name"].string!;
                    
                    // store in reverse
                    AnimeData.animeidsreverse[subJson["name"].string!] = id;
                    
                    // store in info list
                    AnimeData.animeinfo[id] = [
                        "name" : name,
                        "imglink" : subJson["imglink"].string!,
                        "summary" : subJson["summary"].string!,
                        "num_episodes" : subJson["num_episodes"].string!
                    ]
                }
                
                // sort IDs
                for (key, value) in AnimeData.animelist {
                    var arr:[Int] = []
                    for v in value {
                        var str = v as NSString;
                        arr.append(Int(str.intValue));
                    }
                    sort(&arr);
                    var newval: [String] = [];
                    for i in 0...arr.count-1 {
                        newval.append(arr[i].description)
                    }
                    AnimeData.animelist[key] = newval;
                }
                
                // self.tableView.reloadData();
                // self.activityIndicator.stopAnimating();
                // UIApplication.sharedApplication().endIgnoringInteractionEvents();
                self.performSegueWithIdentifier(segueName, sender: nil);
            }
        })
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}
