//
//  Square.swift
//  GTDesigns
//
//  Created by Gaurang on 04/02/16.
//  Copyright © 2016 Droid Master G Entertainment. All rights reserved.
//

import UIKit

@IBDesignable class Square: UIView {
    @IBInspectable var size: CGFloat = 16 {
        didSet {
            self.size = max(16, min(128, self.size))
        }
    }
    
    @IBInspectable var primaryColor: UIColor = UIColor.blueColor()
    @IBInspectable var secondaryColor: UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, primaryColor.CGColor)
        CGContextFillRect(context, rect)
        
        let patternSize: CGSize = CGSizeMake(self.size * 2, self.size * 2)
        let quadrantSize = CGSize(width: self.size, height: self.size)
        let quadrantLength = quadrantSize.width
        
        UIGraphicsBeginImageContextWithOptions(patternSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        primaryColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, patternSize.width, patternSize.height))
        
        for index in 0...3 {
            let xOffsetIndex: CGFloat = CGFloat(index % 2 as Int)
            let yOffsetIndex: CGFloat = CGFloat(index / 2 as Int)
            
            let xOffset = quadrantLength * xOffsetIndex
            let yOffset = quadrantLength * yOffsetIndex
            
            let quadrantPath = UIBezierPath()
            
            quadrantPath.moveToPoint(CGPoint(x:xOffset + quadrantLength * xOffsetIndex, y:yOffset + quadrantLength * (yOffsetIndex * 0.5 + 0.25)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (xOffsetIndex * 0.5 + 0.25), y:yOffset + quadrantLength * yOffsetIndex))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * 0.5, y:yOffset + quadrantLength * yOffsetIndex))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * xOffsetIndex, y:yOffset + quadrantLength * 0.5))
            
            quadrantPath.moveToPoint(CGPoint(x:xOffset + quadrantLength * xOffsetIndex, y:yOffset + quadrantLength * (0.75 - yOffsetIndex * 0.5)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (0.75 - xOffsetIndex * 0.5), y:yOffset + quadrantLength * yOffsetIndex))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (1 - xOffsetIndex), y:yOffset + quadrantLength * yOffsetIndex))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * xOffsetIndex, y:yOffset + quadrantLength * (1 - yOffsetIndex)))
            
            quadrantPath.moveToPoint(CGPoint(x:xOffset + quadrantLength * (xOffsetIndex * 0.5 + 0.25), y:yOffset + quadrantLength * (1 - yOffsetIndex)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (1 - xOffsetIndex), y:yOffset + quadrantLength * (yOffsetIndex * 0.5 + 0.25)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (1 - xOffsetIndex), y:yOffset + quadrantLength * 0.5))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * 0.5, y:yOffset + quadrantLength * (1 - yOffsetIndex)))
            
            quadrantPath.moveToPoint(CGPoint(x:xOffset + quadrantLength * (0.75 - xOffsetIndex * 0.5), y:yOffset + quadrantLength * (1 - yOffsetIndex)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (1 - xOffsetIndex), y:yOffset + quadrantLength * (0.75 - yOffsetIndex * 0.5)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (1 - xOffsetIndex), y:yOffset + quadrantLength * (1 - yOffsetIndex)))
            quadrantPath.addLineToPoint(CGPoint(x:xOffset + quadrantLength * (0.75 - xOffsetIndex * 0.5), y:yOffset + quadrantLength * (1 - yOffsetIndex)))
            
            secondaryColor.setFill()
            quadrantPath.fill()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
