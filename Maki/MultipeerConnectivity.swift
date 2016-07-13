//
//  MuiltpeerConnecting.swift
//  MCSwift
//
//  Created by 刘畅 on 16/5/25.
//  Copyright © 2016年 ArcticCircle. All rights reserved.
//

import Foundation
import MultipeerConnectivity

extension GameViewController {
    
    
    func initMultipeer() {
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // create the browser viewcontroller with a unique service name
        self.browser = MCBrowserViewController(serviceType:serviceType,
                                               session:self.session)
        
        self.browser.delegate = self;
        
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
                                               discoveryInfo:nil, session:self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
        
    }

    func startToConnect() {
        self.presentViewController(self.browser, animated: true, completion: nil)
    }
    
    func startToSend(str: String) {
        
        let msg = "Fuck YOU"
        let final = msg.dataUsingEncoding ( NSUTF8StringEncoding,allowLossyConversion:false)
        
        do
        {
            try self.session.sendData(final!, toPeers: self.session.connectedPeers, withMode: MCSessionSendDataMode.Unreliable)
        }catch{
            return
        }
    }
    
    
    func browserViewControllerDidFinish(
        browserViewController: MCBrowserViewController)  {
            // Called when the browser view controller is dismissed (ie the Done
            // button was tapped)
        
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(
        browserViewController: MCBrowserViewController)  {
            // Called when the browser view controller is cancelled
        
        
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: SESSION DELEGATE
    func session(session: MCSession, didReceiveData data: NSData,
                 fromPeer peerID: MCPeerID)  {
            // Called when a peer sends an NSData to us
            
            // This needs to run on the main queue
            dispatch_async(dispatch_get_main_queue()) {
                
                let msg = NSString(data: data, encoding: NSUTF8StringEncoding)
                
            }
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession,
                 didStartReceivingResourceWithName resourceName: String,
                                                   fromPeer peerID: MCPeerID, withProgress progress: NSProgress)  {
            
            // Called when a peer starts sending a file to us
    }
    
    func session(session: MCSession,
                 didFinishReceivingResourceWithName resourceName: String,
                                                    fromPeer peerID: MCPeerID,
                                                             atURL localURL: NSURL, withError error: NSError?)  {
            // Called when a file has finished transferring from another peer
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream,
                 withName streamName: String, fromPeer peerID: MCPeerID)  {
            // Called when a peer establishes a stream with us
    }
    
    func session(session: MCSession, peer peerID: MCPeerID,
        didChangeState state: MCSessionState)  {
            // Called when a connected peer changes state (for example, goes offline)
            
    }
}

