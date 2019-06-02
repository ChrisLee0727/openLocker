//
//  CGFloatExtension.swift
//  iosGame
//
//  Created by Chris Lee on 01/06/2019.
//  Copyright © 2019 ChrisLee0727. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
    
}
