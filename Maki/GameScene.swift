//
//  GameScene.swift
//  MAKI
//
//  Created by Kelin.Sasha on 7/12/16.
//  Copyright (c) 2016 ArcticCircle. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var appleNode: SKSpriteNode?
    let moveAnalogStick =  🕹(diameter: 110)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        scaleMode=SKSceneScaleMode.AspectFill
        globalUnitLength = ProjectWindow(CGRectGetMaxX(self.frame),
                                         WY: CGRectGetMaxY(self.frame),TX: 16,TY: 10)
        
        backgroundColor = UIColor.whiteColor()
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        moveAnalogStick.position = CGPointMake(moveAnalogStick.radius + 15, moveAnalogStick.radius + 15)
        
        addChild(moveAnalogStick)
        
        
        //MARK: Handlers begin
        
        moveAnalogStick.startHandler = { [unowned self] in
            
            guard let aN = self.appleNode else { return }
            print("Start Tracking")
        }
        
        moveAnalogStick.trackingHandler = { [unowned self] data in
            
            guard let aN = self.appleNode else { return }
            
            
            let pi: CGFloat = 3.1415
            
            if ( data.angular <= pi/4 && data.angular >= -pi/4 ) {
                print("Up")
                aN.position = CGPointMake(aN.position.x , aN.position.y + (data.velocity.y * 0.12))

            }
            else if ( data.angular <= pi/4 * 3 && data.angular >= pi/4 ){
                aN.position = CGPointMake(aN.position.x + (data.velocity.x * 0.12), aN.position.y + (data.velocity.y * 0.12))
                print("Back")
            }
            else if ( data.angular <= -pi/4 && data.angular >= -pi/4 * 3 ) {
                aN.position = CGPointMake(aN.position.x + (data.velocity.x * 0.12), aN.position.y + (data.velocity.y * 0.12))
                print("Forward")
                
            }
            else{
                aN.position = CGPointMake(aN.position.x , aN.position.y + (data.velocity.y * 0.12))
                print("Down")
            }
            
        }
        
        moveAnalogStick.stopHandler = { [unowned self] in
            
            guard let aN = self.appleNode else { return }
            print("End Tracking")
        }
        
        //MARK: Handlers happy end
    
        moveAnalogStick.stick.color = UIColor.lightGrayColor()
        moveAnalogStick.substrate.color = UIColor.blackColor()
        addApple(CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame)))
        
        view.multipleTouchEnabled = true
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        if let touch = touches.first {
            
            let node = nodeAtPoint(touch.locationInNode(self))
            
            switch node {
                
            default:
                print("本来是加苹果的 或者处理按钮的")
            }
        }
    }
    
    func addApple(position: CGPoint) {
        
        guard let appleImage = UIImage(named: "jStick") else { return }
        
        let texture = SKTexture(image: appleImage)
        let apple = SKSpriteNode(texture: texture)
        
        apple.physicsBody = SKPhysicsBody(texture: texture, size: apple.size)
        apple.physicsBody!.affectedByGravity = true
        
        
        insertChild(apple, atIndex: 0)
        apple.position = position
        appleNode = apple
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}


