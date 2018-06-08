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
    @IBOutlet public weak var preView: UIView!
    let ETL = EyesTracking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ETL.sceneView.addSubview(blurEffectView(fromBlurStyle: .dark, frame: self.view.frame))
        ETL.sceneView.addSubview(ETL.faceTrackingDataLabel)
        
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

    func blurEffectView(fromBlurStyle style: UIBlurEffectStyle, frame: CGRect) -> UIVisualEffectView {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = frame
        return blurView
    }

}

