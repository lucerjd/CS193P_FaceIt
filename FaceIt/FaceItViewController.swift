//
//  ViewController.swift
//  FaceIt
//
//  Created by Jonathan Lucero on 6/13/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import UIKit

class FaceItViewController: UIViewController {
    var expression = FacialExpression(eyes: .Closed, mouth: .Smile) { didSet { updateUI() } }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet{
            
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale)))
            let happierSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(FaceItViewController.increaseHappiness))
            happierSwipeGesture.direction = .up
            faceView.addGestureRecognizer(happierSwipeGesture)
            let sadderSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(FaceItViewController.decreaseHappiness))
            sadderSwipeGesture.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGesture)
            updateUI()
        }
    }
    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Neutral: 0.0, .Smirk: -0.5]
    
    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        }
        faceView.mouthCurature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            }
        }
    }
}

