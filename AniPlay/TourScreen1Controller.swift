//
//  TourScreen1Controller.swift
//  AniPlay
//
//  Created by Pranav Harathi on 8/6/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//
//  Log:
//  8/6/15 - Layout finished for iPhone 6 and 6 plus, need to add attributed text (low priority)

import UIKit

class TourScreen1Controller: UIViewController {

    /* To be used for attributed text later on
    @IBDesignable class TIFAttributedLabel: UILabel {
        
        @IBInspectable var fontSize: CGFloat = 22.0
        
        @IBInspectable var fontFamily: String = "Open Sans"
        
        override func awakeFromNib() {
            var attrString = NSMutableAttributedString(attributedString: self.attributedText)
            attrString.addAttribute(NSFontAttributeName, value: UIFont(name: self.fontFamily, size: self.fontSize)!, range: NSMakeRange(0, attrString.length))
            self.attributedText = attrString
        }
    }*/
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = true
        makeLayout();
        
        // Set up swipe right segue
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:");
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left;
        self.view.addGestureRecognizer(swipeLeft);
    }
    
    func swiped(gesture: UIGestureRecognizer) {
        performSegueWithIdentifier("tourscreen1to2", sender: nil);
    }
    
    func makeLayout() {
        
        let screenWidth  = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // All Anime text
        var title = UILabel(frame: CGRectMake((screenWidth/2)-(108), (screenHeight/2)-30.5, 216, 61))
        title.text = "All Anime";
        title.textColor = UIColor(red: CGFloat(0), green: CGFloat(0.604), blue: CGFloat(0.863), alpha: CGFloat(1.0));
        title.font = UIFont(name: "OpenSans-Bold", size: 45.0);
        self.view.addSubview(title);
        // Colors from: http://www.corecoding.com/utilities/rgb-or-hex-to-float.php

        // Description text
        var blurb = UILabel(frame: CGRectMake(title.frame.origin.x-20, title.frame.origin.y+61, 259, 99))
        blurb.lineBreakMode = NSLineBreakMode.ByWordWrapping
        blurb.numberOfLines = 3
        blurb.text = "Large database of free anime for your viewing pleasure."
        blurb.textColor = title.textColor
        blurb.font = UIFont(name: "Open Sans", size: 24.0);
        self.view.addSubview(blurb);
        
        // Image
        var mainImage: UIImage = UIImage(named: "List_Icon.png")!;
        var mainImageView = UIImageView(frame: CGRectMake((screenWidth/2)-72.5, title.frame.origin.y-210, 145, 170));
        mainImageView.image = mainImage;
        self.view.addSubview(mainImageView);
        
        // Pagination
        var pagination = UIImage(named: "Pagination.png");
        var paginationView = UIImageView(frame: CGRectMake((screenWidth/2)-60, title.frame.origin.y+261, 120, 20))
        paginationView.image = pagination!
        self.view.addSubview(paginationView);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

