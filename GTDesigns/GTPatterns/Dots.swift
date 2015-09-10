//
//  Dots.swift
//  GTDesigns
//
//  Created by Gaurang Talwadkar on 02/07/15.
//  Copyright (c) 2015 Droid Master G Entertainment. All rights reserved.
//

import UIKit
import Darwin

@IBDesignable class Dots: UIView {

    @IBInspectable var dotRadius: CGFloat = 5 {
        didSet {
            self.dotRadius = max(1, self.dotRadius)
        }
    }
    
    @IBInspectable var dotGap: CGFloat = 10 {
        didSet {
            self.dotGap = max(1, self.dotGap)
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.darkGrayColor()
    @IBInspectable var dotColor: UIColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, fillColor.CGColor)
        CGContextFillRect(context, rect)
        
        let patternSize: CGSize = CGSizeMake(dotRadius * 2 + dotGap, dotRadius * 2 + dotGap)
        
        UIGraphicsBeginImageContextWithOptions(patternSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        fillColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, patternSize.width, patternSize.height))
        
        let π = M_PI
        
        let dotPath = UIBezierPath()
        
        dotPath.addArcWithCenter(CGPoint(x:patternSize.width/2, y:patternSize.height/2), radius:dotRadius, startAngle:CGFloat(0.0), endAngle:CGFloat(2 * π), clockwise: true)
        
        dotColor.setFill()
        dotPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
