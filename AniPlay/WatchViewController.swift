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
    var webView: WKWebView = WKWebView(frame: UIScreen.mainScreen().bounds);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        super.view.addSubview(webView);
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "unwind:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.webView.addGestureRecognizer(swipeRight);
        //NSURL(string: "http://pranavh.webfactional.com/aniplay/showvideo.php?link=" + link)!)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: link)!));
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
