//
//  ViewController.swift
//  GTDesigns
//
//  Created by Gaurang Talwadkar on 02/07/15.
//  Copyright (c) 2015 Droid Master G Entertainment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: GTSegmentedControl!
    @IBOutlet weak var lightView: UIView!
    @IBOutlet weak var darkView: UIView!
    
    @IBOutlet weak var lightBricks: Bricks!
    @IBOutlet weak var lightHoney: Honeycomb!
    @IBOutlet weak var lightSquare: Square!
    @IBOutlet weak var lightCircles: Circles!
    @IBOutlet weak var lightDots: Dots!
    
    @IBOutlet weak var darkBricks: Bricks!
    @IBOutlet weak var darkHoney: Honeycomb!
    @IBOutlet weak var darkSquare: Square!
    @IBOutlet weak var darkCircles: Circles!
    @IBOutlet weak var darkDots: Dots!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeUI()
    }
    
    func initializeUI() {
        lightView.layer.borderColor = UIColor.darkGrayColor().CGColor
        lightView.layer.borderWidth = 1.0
        
        self.segmentedControl.segments = ["Bricks", "Honey", "Square", "Circles", "Dots"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onValueChange(sender: GTSegmentedControl) {
        self.hideAllViews()
        
        switch sender.selectedIndex {
        case 0:
            self.lightBricks.hidden = false
            self.darkBricks.hidden = false
            break
            
        case 1:
            self.lightHoney.hidden = false
            self.darkHoney.hidden = false
            break
            
        case 2:
            self.lightSquare.hidden = false
            self.darkSquare.hidden = false
            break
            
        case 3:
            self.lightCircles.hidden = false
            self.darkCircles.hidden = false
            break
            
        case 4:
            self.lightDots.hidden = false
            self.darkDots.hidden = false
            break
            
        default: break
        }
    }

    func hideAllViews() {
        self.lightBricks.hidden = true
        self.lightHoney.hidden = true
        self.lightSquare.hidden = true
        self.lightCircles.hidden = true
        self.lightDots.hidden = true
        
        self.darkBricks.hidden = true
        self.darkHoney.hidden = true
        self.darkSquare.hidden = true
        self.darkCircles.hidden = true
        self.darkDots.hidden = true
    }
}

