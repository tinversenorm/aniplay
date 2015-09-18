//
//  WatchViewController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 9/6/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit
import WebKit

class WatchViewController: UIViewController {
    
    var link: String = "";
    var animeName: String = "";
    var episodeNumber: String = "";
    var webView: WKWebView = WKWebView(frame: UIScreen.mainScreen().bounds);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if NSUserDefaults.standardUserDefaults().arrayForKey("history") == nil || (NSUserDefaults.standardUserDefaults().arrayForKey("history")!).count < 1  {
            var historyarr:[String] = [];
            historyarr.append("Episode " + episodeNumber + ":" + animeName);
            NSUserDefaults.standardUserDefaults().setObject(historyarr, forKey: "history");
        } else {
            let historyarr:[String] = NSUserDefaults.standardUserDefaults().arrayForKey("history")! as! [String];
            var newarr:[String] = [];
            newarr.append("Episode " + episodeNumber + ":" + animeName);
            for anime in historyarr {
                newarr.append(anime);
            }
            NSUserDefaults.standardUserDefaults().setObject(historyarr, forKey: "history");
        }
        super.view.addSubview(webView);
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "unwind:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.webView.addGestureRecognizer(swipeRight);
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://pranavh.webfactional.com/aniplay/showvideo.php?link=" + link)!));
    }
    
    func unwind(gesture: UIGestureRecognizer) {
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("unwindToEpisodeList", sender: self);
        });
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
}
