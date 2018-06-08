//
//  ViewController.swift
//  EyesTrackingApp
//
//  Created by AmamiYou on 2018/06/07.
//  Copyright © 2018年 AmamiYou. All rights reserved.
//

import Foundation
import UIKit
import ARKit

class ViewController: UIViewController{
    let ETL = EyesTracking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = ETL.sceneView
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ETL.resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ETL.pouseTracking()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

