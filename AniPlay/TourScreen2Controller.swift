//
//  TourScreen2Controller.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/6/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class TourScreen2Controller: UIViewController {
    
    @IBAction func unwindToThisViewController2(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = true
        makeLayout()
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "unwind:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.view.addGestureRecognizer(swipeRight);
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:");
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        self.view.addGestureRecognizer(swipeLeft);
    }

    func unwind(gesture: UIGestureRecognizer) {
        performSegueWithIdentifier("unwindToThisViewController", sender: self);
    }
    
    func swipe(gesture: UIGestureRecognizer) {
        performSegueWithIdentifier("tourscreen2to3", sender: nil);
    }
    
    func makeLayout() {
        
        let screenWidth  = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // All Anime text
        var title = UILabel(frame: CGRectMake((screenWidth/2)-(87), (screenHeight/2)-30.5, 174, 61))
        title.text = "Current";
        title.textColor = UIColor(red: CGFloat(0), green: CGFloat(0.604), blue: CGFloat(0.863), alpha: CGFloat(1.0));
        title.font = UIFont(name: "OpenSans-Bold", size: 45.0);
        self.view.addSubview(title);
        // Colors from: http://www.corecoding.com/utilities/rgb-or-hex-to-float.php
        
        // Description text
        var blurb = UILabel(frame: CGRectMake((screenWidth/2)-141, title.frame.origin.y+61, 282, 66))
        blurb.lineBreakMode = NSLineBreakMode.ByWordWrapping
        blurb.numberOfLines = 2
        blurb.text = "Constantly updated with anime from this season."
        blurb.textColor = title.textColor
        blurb.font = UIFont(name: "Open Sans", size: 24.0);
        self.view.addSubview(blurb);
        
        
        // Image
        var mainImage: UIImage = UIImage(named: "Updated_Icon.png")!;
        var mainImageView = UIImageView(frame: CGRectMake((screenWidth/2)-70, title.frame.origin.y-191, 140, 140));
        mainImageView.image = mainImage;
        self.view.addSubview(mainImageView);
        
        // Pagination
        var pagination = UIImage(named: "Pagination2.png");
        var paginationView = UIImageView(frame: CGRectMake((screenWidth/2)-60, title.frame.origin.y+261, 120, 20))
        paginationView.image = pagination!
        self.view.addSubview(paginationView);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
