//
//  WatchedAnimeController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class WatchedAnimeController: UIViewController {
    
    @IBOutlet var navBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBarHidden = true;
        makeLayout();
    }
    
    func makeLayout() {
        navBar.setTitleVerticalPositionAdjustment(-5.0, forBarMetrics: UIBarMetrics.Default);
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "OpenSans-Bold", size: 28.0)!, NSForegroundColorAttributeName : UIColor(red: CGFloat(0.518), green: CGFloat(0.518), blue: CGFloat(0.518), alpha: CGFloat(1.0))];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
