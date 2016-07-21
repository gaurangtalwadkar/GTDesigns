//
//  GTStepSlider.swift
//  GTDesigns
//
//  Created by Gaurang Talwadkar on 22/07/16.
//  Copyright © 2016 Droid Master G Entertainment. All rights reserved.
//

import UIKit

@IBDesignable class GTStepSlider: UIControl {
    
    private var labels = [UILabel]()
    var thumbView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
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
    
    @IBInspectable var bgColor : UIColor = UIColor.clearColor() {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    var steps: [String] = ["Low", "Medium", "High"] {
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var selectedIndex : Int = 0 {
        didSet {
            self.selectedIndex = max(0, min(steps.count - 1, self.selectedIndex))
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
    
    var font : UIFont! = UIFont(name: "Avenir Next", size: 12) {
        didSet {
            setFont()
        }
    }
    
    @IBInspectable var thumbSelectorColor : UIColor = UIColor(red: 180.0/255.0, green: 235.0/255.0, blue: 1.0, alpha: 1.0) {
        didSet {
            setupThumbView()
        }
    }
    
    @IBInspectable var thumbSelectorHeight : CGFloat = 2 {
        didSet {
            self.thumbSelectorHeight = max(2, min(4, self.thumbSelectorHeight))
            setupThumbView()
        }
    }
    
    func setupThumbView() {
        var selectFrame = self.bounds
        let thumbWidth = CGRectGetWidth(selectFrame)/CGFloat(steps.count)
        selectFrame.size.width = thumbWidth
        thumbView.frame = selectFrame
        thumbView.backgroundColor = thumbColor
        for view in (thumbView.subviews ) {
            view.removeFromSuperview()
        }
        
        let thumbSelector = UIView()
        
        thumbSelector.frame = CGRectMake(CGRectGetMinX(selectFrame), 0, CGRectGetWidth(selectFrame), thumbSelectorHeight)
        thumbSelector.backgroundColor = thumbSelectorColor
        thumbView.addSubview(thumbSelector)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        var calculatedIndex : Int?
        for (index, item) in labels.enumerate() {
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
        for (_, item) in labels.enumerate() {
            item.textColor = unselectedLabelColor
        }
        
        let label = labels[selectedIndex]
        label.textColor = selectedLabelColor
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations:{
            self.thumbView.frame = label.frame
            }, completion: nil)
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepCapacity: true)
        
        for index in 1...steps.count {
            let label = UILabel(frame: CGRectZero)
            label.text = steps[index - 1]
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = UIFont(name: "Avenir Next", size: 15)
            label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
            label.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(label)
            labels.append(label)
        }
        
        addIndividualItemConstraints(labels, mainView: self, padding: 0)
    }
    
    func addIndividualItemConstraints(steps: [UIView], mainView: UIView, padding: CGFloat) {
        for (index, button) in steps.enumerate() {
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint: NSLayoutConstraint!
            
            if index == steps.count - 1 {
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -padding)
            } else {
                let nextButton = steps[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: nextButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -padding)
            }
            
            var leftConstraint: NSLayoutConstraint!
            
            if index == 0 {
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: mainView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: padding)
            } else {
                let prevButton = steps[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: prevButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: padding)
                
                let firstItem = steps[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: firstItem, attribute: .Width, multiplier: 1.0  , constant: 0)
                
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
