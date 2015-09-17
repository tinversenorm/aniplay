//
//  TabBar.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    /*
    override func intrinsicContentSize() -> CGSize {
        var intrinsicSize = super.frame.size
        intrinsicSize.height = 200
        return intrinsicSize
    }*/
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80
        
        return sizeThatFits
    }
}