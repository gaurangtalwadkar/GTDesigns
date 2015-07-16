//
//  GTSegmentedControl.swift
//  GTDesigns
//
//  Created by Gaurang Talwadkar on 15/07/15.
//  Copyright (c) 2015 Droid Master G Entertainment. All rights reserved.
//

import UIKit

@IBDesignable class GTSegmentedControl: UIControl {

    private var labels = [UILabel]()
    var thumbView = UIView()
    
    @IBInspectable var bgColor : UIColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0) {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    var segments: [String] = ["Segment 1", "Segment 2"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    @IBInspectable var selectedLabelColor : UIColor = UIColor.darkGrayColor() {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var unselectedLabelColor : UIColor = UIColor.orangeColor() {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var thumbColor : UIColor = UIColor.lightGrayColor() {
        didSet {
            setSelectedColors()
        }
    }
    
    @IBInspectable var font : UIFont! = UIFont(name: "Avenir Next", size: 12) {
        didSet {
            setFont()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = bgColor
        
        setupLabels()
        
        addIndividualItemConstraints(labels, mainView: self, padding: 0)
        
        insertSubview(thumbView, atIndex: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupThumbView()
        
        displayNewSelectedIndex()
    }
    
    func setupThumbView() {
        var selectFrame = self.bounds
        let thumbWidth = CGRectGetWidth(selectFrame)/CGFloat(segments.count)
        selectFrame.size.width = thumbWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
        
        var thumbSelector = UIView()
        thumbSelector.frame = CGRectMake(CGRectGetMinX(selectFrame), CGRectGetMaxY(selectFrame) - 2, CGRectGetWidth(selectFrame), 2)
        thumbSelector.backgroundColor = UIColor.cyanColor()
        thumbView.addSubview(thumbSelector)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let location = touch.locationInView(self)
        
        var calculatedIndex : Int?
        for (index, item) in enumerate(labels) {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedIndex() {
        for (index, item) in enumerate(labels) {
            item.textColor = unselectedLabelColor
        }
        
        var label = labels[selectedIndex]
        label.textColor = selectedLabelColor
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations:{
            self.thumbView.frame = label.frame
            }, completion: nil)
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepCapacity: true)
        
        for index in 1...segments.count {
            let label = UILabel(frame: CGRectZero)
            label.text = segments[index - 1]
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = UIFont(name: "Avenir Next", size: 15)
            label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(label)
            labels.append(label)
        }
        
        addIndividualItemConstraints(labels, mainView: self, padding: 0)
    }
    
    func addIndividualItemConstraints(segments: [UIView], mainView: UIView, padding: CGFloat) {
        let constraints = mainView.constraints()
        
        for (index, button) in enumerate(segments) {
            var topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
            
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint: NSLayoutConstraint!
            
            if index == segments.count - 1 {
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -padding)
            } else {
                let nextButton = segments[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: nextButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -padding)
            }
            
            var leftConstraint: NSLayoutConstraint!
            
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: padding)
            } else {
                let prevButton = segments[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: prevButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: padding)
                
                let firstItem = segments[0]
                
                var widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: firstItem, attribute: .Width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    func setSelectedColors(){
        for item in labels {
            item.textColor = unselectedLabelColor
        }
        
        if labels.count > 0 {
            labels[0].textColor = selectedLabelColor
        }
        
        thumbView.backgroundColor = thumbColor
    }
    
    func setFont(){
        for item in labels {
            item.font = font
        }
    }

}
