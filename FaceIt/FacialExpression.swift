//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Jonathan Lucero on 6/13/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import Foundation

struct FacialExpression {
    enum Eyes: Int {
        case Open
        case Closed
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
    }
    
    var eyes: Eyes
    var mouth: Mouth
}
