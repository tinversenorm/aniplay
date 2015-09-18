//
//  AnimeViewController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/20/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class AnimeViewController: UIViewController {
    
    var animeName: String = "";
    
    @IBOutlet var summaryText: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func unwindToAnime(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBarHidden = true;
        
        // load image
        let animeID = AnimeData.animeidsreverse[self.animeName];
        var animeInfo = AnimeData.animeinfo[animeID!];
        let imglink = animeInfo!["imglink"];
        let summary = animeInfo!["summary"];
        var numEpisodes = animeInfo!["num_episodes"];
        //println(imglink);
        
        var image = UIImage();
        // download image
        let q:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(q, {
            /* Fetch the image from the server... */
            let data:NSData = NSData(contentsOfURL: NSURL(string: imglink!)!)!;
            let img:UIImage = UIImage(data: data)!;
            dispatch_async(dispatch_get_main_queue(), {
                /* Attempt to mask image, for now will keep on hold */
                //var masked = self.maskImage(img, withMask: UIImage(named: "Mask.png")!);
                //self.imageView.image = masked;
                self.imageView.contentMode = UIViewContentMode.ScaleAspectFit;
                self.imageView.image = img;
            });
        });
        
        makeLayout(summary: summary!);
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "unwind:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.view.addGestureRecognizer(swipeRight);
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "episodes:");
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        self.view.addGestureRecognizer(swipeLeft);
    }
    
    func unwind(gesture: UIGestureRecognizer) {
        // force modal segue to move to UI thread
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("unwindToAll", sender: self);
        })
    }
    
    func episodes(gesture: UIGestureRecognizer) {
        // force modal segue to move to UI thread
        dispatch_async(dispatch_get_main_queue(),{
            self.performSegueWithIdentifier("showEpisodes", sender: nil);
        });
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEpisodes" || segue.identifier == "showEpisodesButton" {
            let destVC: EpisodeViewController = segue.destinationViewController as! EpisodeViewController;
            destVC.animeName = self.animeName;
        }
    }
    
    func makeLayout(mask: UIImage = UIImage(named: "Mask.jpg")!, summary: String) {
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width;
        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height;
        
        titleLabel.text = animeName;
        titleLabel.frame.size.width = screenWidth;
        
        // AniPlay Icon -- might make it a button
        let aniplayImage = UIImage(named: "Home_Icon.png");
        let aniplayView = UIImageView(frame: CGRectMake(30, 38, 53, 45))
        aniplayView.image = aniplayImage;
        self.view.addSubview(aniplayView);
        
        // set image View to be directly above
        // might add a nice frame later or eventually mask with a circle
        imageView.frame = CGRectMake(screenWidth/2 - 100, aniplayView.frame.origin.y + aniplayView.frame.height, 200, 200);
        imageView.image = mask;
        self.view.addSubview(imageView);
        
        
        // add UI Buttons
        
        
        // Menu Icon
        let menuIcon = UIImage(named: "Menu Icon.png");
        let menuIconView = UIImageView(frame: CGRectMake(screenWidth-(29+42), 39, 42, 35));
        menuIconView.image = menuIcon!;
        self.view.addSubview(menuIconView);
        
        // Add summary text/label
        summaryLabel.frame.origin.x = titleLabel.frame.origin.x;
        summaryText.textContainer.lineFragmentPadding = 0;
        summaryText.textContainerInset = UIEdgeInsetsZero;
        summaryText.text = summary;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
}
