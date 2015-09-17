//
//  TabBarController.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewWillLayoutSubviews() {
    }
    
    @IBAction func unwindToTabBarController(segue: UIStoryboardSegue) {
    }
    
    override func viewControllerForUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject?) -> UIViewController? {
        var resultVC = self.selectedViewController?.viewControllerForUnwindSegueAction(action, fromViewController: fromViewController, withSender: sender)
        return resultVC
    }
}
