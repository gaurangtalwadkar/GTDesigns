//
//  Circles.swift
//  GTDesigns
//
//  Created by Gaurang Shenvi Talwadkar on 30/03/16.
//  Copyright © 2016 Droid Master G Entertainment. All rights reserved.
//

import UIKit

@IBDesignable class Circles: UIView {
    @IBInspectable var size: CGFloat = 16 {
        didSet {
            self.size = max(16, min(128, self.size))
        }
    }
    
    @IBInspectable var primaryColor: UIColor = UIColor.brownColor()
    @IBInspectable var secondaryColor: UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, primaryColor.CGColor)
        CGContextFillRect(context, rect)
        
        let patternSize: CGSize = CGSizeMake(self.size, self.size)
        
        UIGraphicsBeginImageContextWithOptions(patternSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        primaryColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, patternSize.width, patternSize.height))
        
        let circlePath = UIBezierPath()
        
        circlePath.moveToPoint(CGPoint(x: self.size * 0.5, y: self.size * 0.5))
        circlePath.addArcWithCenter(CGPoint(x: self.size * 0.5, y: self.size * 0.5), radius: self.size * 0.5, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        circlePath.addArcWithCenter(CGPoint(x: 0, y: 0), radius: self.size * 0.5, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)
        circlePath.addArcWithCenter(CGPoint(x: 0, y: self.size), radius: self.size * 0.5, startAngle: CGFloat(M_PI_2 + M_PI), endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        circlePath.addArcWithCenter(CGPoint(x: self.size, y: self.size), radius: self.size * 0.5, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2 + M_PI), clockwise: true)
        
        circlePath.moveToPoint(CGPoint(x: self.size, y: self.size * 0.5))
        circlePath.addArcWithCenter(CGPoint(x: self.size, y: 0), radius: self.size * 0.5, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
        
        secondaryColor.setFill()
        circlePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
