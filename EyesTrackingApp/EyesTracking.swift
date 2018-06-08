//
//  EyesTracking.swift
//  EyesTrackingApp
//
//  Created by AmamiYou on 2018/06/07.
//  Copyright © 2018年 AmamiYou. All rights reserved.
//

import Foundation
import ARKit
import UIKit
import SceneKit

class EyesTracking:NSObject,ARSCNViewDelegate,ARSessionDelegate{
    var sceneView = ARSCNView()
    var faceTrackingDataLabel = UILabel()
    var session: ARSession {
        return sceneView.session
    }
    var currentFaceAnchor: ARFaceAnchor?
    var currentFrame: ARFrame?
    
    override init() {
        guard ARFaceTrackingConfiguration.isSupported else {
            NSLog("This device not supported FaceTracking !")
            return
        }
        
        sceneView.backgroundColor = .clear
        sceneView.scene = SCNScene()
        sceneView.rendersContinuously = true
        
        UIApplication.shared.isIdleTimerDisabled = true //Stop auto sleep
        sceneView.preferredFramesPerSecond = 60
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.showsStatistics = true
        
        faceTrackingDataLabel.backgroundColor = UIColor.clear
        faceTrackingDataLabel.textColor = UIColor.white
        faceTrackingDataLabel.tintColor = UIColor.white
        faceTrackingDataLabel.adjustsFontSizeToFitWidth = true;
        faceTrackingDataLabel.contentScaleFactor = 10.0
        faceTrackingDataLabel.textAlignment = .center
        faceTrackingDataLabel.numberOfLines = 0
        //faceTrackingDataLabel.sizeToFit()
    }
    
    func resetTracking(){
        NSLog("Settion reset.")
        faceTrackingDataLabel.frame = CGRect(x: 0, y: 30.0, width: sceneView.frame.width, height: sceneView.frame.height-60.0)
        faceTrackingDataLabel.text = "Resut of face"
        
        print(faceTrackingDataLabel)
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true //add lighting
        configuration.worldAlignment = .gravity
        session.delegate = self
        session.run(configuration, options:[.resetTracking, .removeExistingAnchors])
    }
    
    func pouseTracking(){
        NSLog("Settion pause.")
        session.pause()
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {//update tracking
        self.currentFrame = frame
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {//add face
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {//update face tracking
        guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }
        self.currentFaceAnchor = faceAnchor
        NSLog("-----------------------------")
        NSLog("%@",faceAnchor.blendShapes)
        
        var text=""
        for i in faceAnchor.blendShapes{
            if i.key.rawValue.contains("eye"){
                let a = String(i.key.rawValue) + ":" + String(Float(i.value)*100) + "\n"
                text += a
            }
        }
        
        faceTrackingDataLabel.text = text
        
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {//remove face
    }
    
    //中断した時
    func sessionWasInterrupted(_ session: ARSession) {
        print("SESSION INTERRUPTED")
    }
    //中断再開した時
    func sessionInterruptionEnded(_ session: ARSession) {
        DispatchQueue.main.async {
            self.resetTracking() //セッション再開
        }
    }
    
    
}




