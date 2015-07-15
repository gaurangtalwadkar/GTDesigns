//
//  Bricks.swift
//  GTDesigns
//
//  Created by Gaurang Talwadkar on 02/07/15.
//  Copyright (c) 2015 Droid Master G Entertainment. All rights reserved.
//

import UIKit

@IBDesignable class Bricks: UIView {
    
    var internalSize: CGFloat = 50
    @IBInspectable var size: CGFloat {
        get {
            return self.internalSize
        }
        
        set(newValue) {
            self.internalSize = max(20, newValue)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet {
            self.borderWidth = max(1, min(5, self.borderWidth))
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.redColor()
    @IBInspectable var borderColor: UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, borderColor.CGColor)
        CGContextFillRect(context, rect)
        
        var patternSize: CGSize = CGSizeMake(size, size)
    
        UIGraphicsBeginImageContextWithOptions(patternSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        borderColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, patternSize.width, patternSize.height))
        
        let brickPath = UIBezierPath()
        
        brickPath.moveToPoint(CGPoint(x:borderWidth/2, y:borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width - borderWidth/2, y:borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width - borderWidth/2, y:patternSize.height/2 - borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:borderWidth/2, y:patternSize.height/2 - borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:borderWidth/2, y:borderWidth/2))
        
        brickPath.moveToPoint(CGPoint(x:0, y:patternSize.height/2 + borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width/2 - borderWidth/2, y:patternSize.height/2 + borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width/2 - borderWidth/2, y:patternSize.height - borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:0, y:patternSize.height - borderWidth/2))
        
        brickPath.moveToPoint(CGPoint(x:patternSize.width, y:patternSize.height/2 + borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width/2 + borderWidth/2, y:patternSize.height/2 + borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width/2 + borderWidth/2, y:patternSize.height - borderWidth/2))
        brickPath.addLineToPoint(CGPoint(x:patternSize.width, y:patternSize.height - borderWidth/2))
        
        fillColor.setFill()
        brickPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
