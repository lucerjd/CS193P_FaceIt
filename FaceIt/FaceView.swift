//
//  FaceView.swift
//  FaceIt
//
//  Created by Jonathan Lucero on 6/13/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import UIKit

class FaceView: UIView {
    var scale = 0.90
    var mouthCurature = 1.0

    
    private var faceRadius: CGFloat {
        return min(bounds.size.width,bounds.size.height) / 2
    }
    private var faceCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private struct Ratios {
        static let FaceRadiusToEyeOffset: CGFloat = 3
        static let FaceRadiusToEyeRadius: CGFloat = 10
        static let FaceRadiusToMouthWidth: CGFloat = 1
        static let FaceRadiusToMouthHeight: CGFloat = 3
        static let FaceRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*Double.pi),
            clockwise: true)
        path.lineWidth = 5.0
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = faceRadius / Ratios.FaceRadiusToEyeOffset
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeOffset
        switch eye {
            case .Left: eyeCenter.x -= eyeOffset
            case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Ratios.FaceRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye: eye)
        return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = faceRadius / Ratios.FaceRadiusToMouthWidth
        let mouthHeight = faceRadius / Ratios.FaceRadiusToMouthHeight
        let mouthOffset = faceRadius / Ratios.FaceRadiusToMouthOffset
        
        let mouthRect = CGRect(x: faceCenter.x - mouthWidth/2, y: faceCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        let smileOffset = CGFloat(max(-1, min(mouthCurature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let controlPoint = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let controlPoint2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: controlPoint, controlPoint2: controlPoint2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForCircleCenteredAtPoint(midPoint: faceCenter, withRadius: faceRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
    }

}
