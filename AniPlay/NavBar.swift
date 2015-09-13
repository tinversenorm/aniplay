//
//  NavBar.swift
//  AniPlay
//
//  Created by Sita Mulomudi on 8/9/15.
//  Copyright (c) 2015 TinverseNorm. All rights reserved.
//

import UIKit

class NavBar: UINavigationBar {
    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 83.0
        return sizeThatFits
    }
}

