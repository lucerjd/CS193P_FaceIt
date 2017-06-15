//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Jonathan Lucero on 6/15/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    let emotions = ["angry" : FacialExpression(eyes: .Closed, mouth: .Frown),
                    "happy" : FacialExpression(eyes: .Open, mouth: .Smile),
                    "sleeping" : FacialExpression(eyes: .Closed, mouth: .Neutral)]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination;
        
        if let destination = segue.destination as? UINavigationController {
            destinationVC = destination.visibleViewController ?? destinationVC
        }
        
        if let faceViewController = destinationVC as? FaceItViewController {
            
            if let emotion = segue.identifier {
                faceViewController.expression = emotions[emotion]!
            }
        }
        if let button = sender as? UIButton {
            destinationVC.title = button.currentTitle
        }
    }

}
