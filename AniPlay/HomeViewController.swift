//
//  HomeViewController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/7/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//
//  9/6/15: All segues except menu work

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    var searchBar: UITextField! = UITextField(frame: CGRectMake((UIScreen.mainScreen().bounds.width/2)-124, (UIScreen.mainScreen().bounds.height/2)-19, 248.0, 38.0));
    
    class Buttons {
        static var curIconView: UIButton = UIButton();
        static var allIconView: UIButton = UIButton();
        static var watchedIconView: UIButton = UIButton();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true;
        self.searchBar.delegate = self;
        makeLayout();
        // Do any additional setup after loading the view.
        Buttons.allIconView.addTarget(self, action: "goToAll:", forControlEvents: UIControlEvents.TouchUpInside);
        Buttons.curIconView.addTarget(self, action: "goToCurrent:", forControlEvents: UIControlEvents.TouchUpInside);
        Buttons.watchedIconView.addTarget(self, action: "goToWatched:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    func makeLayout() {
        let screenWidth  = UIScreen.mainScreen().bounds.width;
        let screenHeight = UIScreen.mainScreen().bounds.height;
        
        self.view.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 0.965, alpha: 1.0)
        
        /* Center search bar
        searchBar.borderStyle = UITextBorderStyle.RoundedRect;
        searchBar.font = UIFont(name: "Open Sans", size: 14.0);
        searchBar.textColor = UIColor(red: CGFloat(0), green: CGFloat(0.604), blue: CGFloat(0.863), alpha: CGFloat(1.0));
        searchBar.placeholder = "AniPlay Search"
        
        searchBar.backgroundColor = UIColor.whiteColor();
        searchBar.layer.borderColor = searchBar.textColor.CGColor;
        searchBar.layer.borderWidth = 3
        searchBar.layer.cornerRadius = 4.5
        self.view.addSubview(searchBar);*/
        
        // AniPlay Icon
        let aniplayImage = UIImage(named: "Home_Icon.png");
        let aniplayView = UIImageView(frame: CGRectMake((screenWidth/2)-56, searchBar.frame.origin.y-138, 112, 96))
        aniplayView.image = aniplayImage!;
        self.view.addSubview(aniplayView);
        
        // Menu Icon
        let menuIcon = UIImage(named: "Menu Icon.png");
        let menuIconView = UIImageView(frame: CGRectMake(screenWidth-(29+42), 39, 42, 35));
        menuIconView.image = menuIcon!;
        self.view.addSubview(menuIconView);
        
        // Current Anime Icon
        let curIcon = UIImage(named: "Updated_Icon_Tab.png");
        Buttons.curIconView = UIButton(frame: CGRectMake((screenWidth/2)-23, screenHeight-(36+46), 46, 46))
        Buttons.curIconView.setImage(curIcon, forState: UIControlState.Normal);
        self.view.addSubview(Buttons.curIconView);
        
        // All Anime Icon
        let allIcon = UIImage(named: "List_Icon_Tab.png");
        Buttons.allIconView = UIButton(frame: CGRectMake(44, Buttons.curIconView.frame.origin.y-3, 44, 53));
        Buttons.allIconView.setImage(allIcon, forState: UIControlState.Normal);
        self.view.addSubview(Buttons.allIconView);
        
        // Watched Icon
        let watchedIcon = UIImage(named: "History_Icon_Tab.png");
        Buttons.watchedIconView = UIButton(frame: CGRectMake(screenWidth-(38+53), Buttons.curIconView.frame.origin.y, 53, 46));
        Buttons.watchedIconView.setImage(watchedIcon, forState: UIControlState.Normal);
        self.view.addSubview(Buttons.watchedIconView);
        
        //Subtitles
        subtitleStyle(UILabel(), text: "All", iconView: Buttons.allIconView);
        subtitleStyle(UILabel(), text: "Current", iconView: Buttons.curIconView);
        subtitleStyle(UILabel(), text: "Watched", iconView: Buttons.watchedIconView);
        
    }
    
    func subtitleStyle(label: UILabel, text: String, color: UIColor = UIColor(red: CGFloat(0.518), green: CGFloat(0.518), blue: CGFloat(0.518), alpha: CGFloat(1.0)), font: UIFont = UIFont(name: "OpenSans-Bold", size: 12.0)!, iconView: UIButton) {
        label.text = text;
        label.textColor = color;
        label.font = font;
        label.sizeToFit();
        label.textAlignment = NSTextAlignment.Center;
        label.frame.origin.x = (iconView.frame.origin.x+iconView.frame.size.width/2)-(label.frame.width/2);
        var num:CGFloat = 6;
        if text == "All" {
            num = 3;
        }
        label.frame.origin.y = (iconView.frame.origin.y+iconView.frame.size.height+num);
        self.view.addSubview(label);
    }
    
    func goToAll(sender: AnyObject){
        performSegueWithIdentifier("hometotabbarcontroller", sender: sender);
    }
    
    func goToCurrent(sender: AnyObject) {
        performSegueWithIdentifier("hometocurrenttab", sender: sender);
    }
    
    func goToWatched(sender: AnyObject) {
        performSegueWithIdentifier("hometowatchedtab", sender: sender);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "hometocurrenttab") {
            let destTabBarController:UITabBarController = segue.destinationViewController as! UITabBarController;
            destTabBarController.selectedIndex = 1;
        }
        if (segue.identifier == "hometowatchedtab") {
            let destTabBarController:UITabBarController = segue.destinationViewController as! UITabBarController;
            destTabBarController.selectedIndex = 2;
        }
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
