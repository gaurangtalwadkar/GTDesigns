//
//  Honeycomb.swift
//  GTDesigns
//
//  Created by Gaurang Talwadkar on 30/06/15.
//  Copyright (c) 2015 Droid Master G Entertainment. All rights reserved.
//

import UIKit

@IBDesignable class Honeycomb: UIView {
    
    @IBInspectable var size: CGFloat = 1 {
        didSet {
            self.size = max(1, min(5, self.size))
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 3 {
        didSet {
            self.borderWidth = max(1, min(3, self.borderWidth))
        }
    }
    
    @IBInspectable var backgroundFillColor: UIColor = UIColor.darkGrayColor()
    @IBInspectable var borderColor: UIColor = UIColor.yellowColor()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, borderColor.CGColor)
        CGContextFillRect(context, rect)
        
        let patternSize: CGSize = CGSizeMake(self.size * 29, self.size * 19)
        let hexSize = CGSize(width: (patternSize.height - borderWidth), height: (patternSize.height - borderWidth))
        
        UIGraphicsBeginImageContextWithOptions(patternSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        borderColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, patternSize.width, patternSize.height))
        
        let hexPath = UIBezierPath()
        
        hexPath.moveToPoint(CGPoint(x:0, y:borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:hexSize.width/2, y:borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:3 * hexSize.width/4, y:patternSize.height/2))
        hexPath.addLineToPoint(CGPoint(x:hexSize.width/2, y:patternSize.height - borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:0, y:patternSize.height - borderWidth/2))
        
        hexPath.moveToPoint(CGPoint(x:hexSize.width/2 + borderWidth, y:0))
        hexPath.addLineToPoint(CGPoint(x:3 * hexSize.width/4 + borderWidth, y:patternSize.height/2 - borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:patternSize.width - (hexSize.width/4 + borderWidth), y:patternSize.height/2 - borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:patternSize.width - borderWidth, y:0))
        
        hexPath.moveToPoint(CGPoint(x:hexSize.width/2 + borderWidth, y:patternSize.height))
        hexPath.addLineToPoint(CGPoint(x:3 * hexSize.width/4 + borderWidth, y:patternSize.height/2 + borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:patternSize.width - (hexSize.width/4 + borderWidth), y:patternSize.height/2 + borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:patternSize.width - borderWidth, y:patternSize.height))
        
        hexPath.moveToPoint(CGPoint(x:patternSize.width, y:borderWidth/2))
        hexPath.addLineToPoint(CGPoint(x:patternSize.width - hexSize.width/4, y:patternSize.height/2))
        hexPath.addLineToPoint(CGPoint(x:patternSize.width, y:patternSize.height - borderWidth/2))
        
        backgroundFillColor.setFill()
        hexPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
