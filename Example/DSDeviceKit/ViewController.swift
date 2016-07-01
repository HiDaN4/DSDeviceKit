//
//  ViewController.swift
//  DSDeviceKit
//
//  Created by Dmitry Sokolov on 06/30/2016.
//  Copyright (c) 2016 Dmitry Sokolov. All rights reserved.
//

import UIKit
import DSDeviceKit

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpDeviceInfoLabel()
    }
    
    
    func setUpDeviceInfoLabel() {
        
        let device = DSDeviceKit.currentDevice
        
        let okToExecute = ["iPhone 5s", "iphone 6", "iPad Pro", "ipad air", "simulator"]
        
        infoLabel.text = "Model: \(device.modelName)\niOS Version: \(device.iOSVersion)\nDevice type: \(device.deviceType)\nSystem identifier: \(device.identifier)\n\nIs iPhone? : \(device.isPhone)\nIs iPad? : \(device.isIPad)\n\nList of devices:\n\(okToExecute)\n\nIs in the list? : \(device.isOneOf(okToExecute))"
        
    }

}

