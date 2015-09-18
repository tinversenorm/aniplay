//
//  TourScreen3Controller.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/7/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class TourScreen3Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        makeLayout();

        // Do any additional setup after loading the view.
        // Unwind Segue
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "unwind:");
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right;
        self.view.addGestureRecognizer(swipeRight);
        
    }
    
    func unwind(gesture: UIGestureRecognizer) {
        performSegueWithIdentifier("unwindToThisViewController2", sender: self)
    }
    
    func makeLayout() {
        let screenWidth  = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // All Anime text
        let title = UILabel(frame: CGRectMake((screenWidth/2)-(99), (screenHeight/2)-30.5, 198, 61))
        title.text = "Watched";
        title.textColor = UIColor(red: CGFloat(0), green: CGFloat(0.604), blue: CGFloat(0.863), alpha: CGFloat(1.0));
        title.font = UIFont(name: "OpenSans-Bold", size: 45.0);
        self.view.addSubview(title);
        // Colors from: http://www.corecoding.com/utilities/rgb-or-hex-to-float.php
        
        // Description text
        let blurb = UILabel(frame: CGRectMake((screenWidth/2)-150, title.frame.origin.y+61, 300, 99))
        blurb.lineBreakMode = NSLineBreakMode.ByWordWrapping
        blurb.numberOfLines = 3
        blurb.text = "Keep track of all the anime that you love so you can watch it again."
        blurb.textColor = title.textColor
        blurb.font = UIFont(name: "Open Sans", size: 24.0);
        self.view.addSubview(blurb);
        
        // Image
        let mainImage: UIImage = UIImage(named: "History_Icon.png")!;
        let mainImageView = UIImageView(frame: CGRectMake((screenWidth/2)-mainImage.size.width/2, title.frame.origin.y-((mainImage.size.height)+40), mainImage.size.width, mainImage.size.height));
        mainImageView.image = mainImage;
        self.view.addSubview(mainImageView);
        
        // Pagination
        let pagination = UIImage(named: "Pagination3.png");
        let paginationView = UIImageView(frame: CGRectMake((screenWidth/2)-60, title.frame.origin.y+261, 120, 20))
        paginationView.image = pagination!
        self.view.addSubview(paginationView);
        
        // Done Button
        let doneButton = UIButton(frame: CGRectMake(screenWidth-88, 25, 61, 33));
        doneButton.titleLabel?.font = UIFont(name: "Open Sans", size: 24.0);
        doneButton.titleLabel?.text = "Done"
        doneButton.titleLabel?.textColor = title.textColor
        doneButton.setTitleColor(title.textColor, forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Normal);
        doneButton.setTitleColor(UIColor(red: CGFloat(0), green: CGFloat(0.604), blue: CGFloat(0.863), alpha: CGFloat(0.5)), forState: UIControlState.Highlighted);
        doneButton.addTarget(self, action: "pressedAction:", forControlEvents: .TouchUpInside);
        self.view.addSubview(doneButton);
    }
    
    func pressedAction(sender: UIButton!) {
        performSegueWithIdentifier("tourtohomescreen", sender: nil);
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
