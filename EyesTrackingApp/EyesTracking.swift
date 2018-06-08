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
    var session: ARSession {
        return sceneView.session
    }
    
    override init() {
        guard ARFaceTrackingConfiguration.isSupported else {
            NSLog("This device not supported FaceTracking !")
            return
        }
        
        self.sceneView.backgroundColor = .clear
        self.sceneView.scene = SCNScene()
        self.sceneView.rendersContinuously = true
        
        UIApplication.shared.isIdleTimerDisabled = true //Stop auto sleep
        self.sceneView.preferredFramesPerSecond = 64
        self.sceneView.automaticallyUpdatesLighting = true
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.showsStatistics = true
    }
    
    func resetTracking(){
        NSLog("Settion reset.")
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
    
    var currentFaceAnchor: ARFaceAnchor?
    var currentFrame: ARFrame?
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {//update tracking
        self.currentFrame = frame
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {//add face
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {//update face tracking
        guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }
        self.currentFaceAnchor = faceAnchor
        for i in faceAnchor.blendShapes{
            NSLog("%@,%f",i.key.rawValue,i.value.floatValue)
        }
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




