//
//  GameViewController.swift
//  MAKI
//
//  Created by Kelin.Sasha on 7/12/16.
//  Copyright (c) 2016 ArcticCircle. All rights reserved.
//

import UIKit
import SpriteKit
import MultipeerConnectivity


class GameViewController: UIViewController, MCBrowserViewControllerDelegate, MCSessionDelegate {
    
    // For MC Module
    let serviceType = "MCConnect"
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Configure the view.
        let scene = GameScene(size: self.view.bounds.size)
        scene.backgroundColor = .whiteColor()
        if let skView = self.view as? SKView {
            skView.showsFPS = true
            skView.showsNodeCount = true
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            /* Set the scale mode to scale to fit the window */
            //scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // Init MC Module
        initMultipeer()
        startToConnect()
    }
    
        
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask  {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
