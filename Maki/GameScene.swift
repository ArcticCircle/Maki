//
//  GameScene.swift
//  MAKI
//
//  Created by Kelin.Sasha on 7/12/16.
//  Copyright (c) 2016 ArcticCircle. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        self.scaleMode=SKSceneScaleMode.AspectFill
        self.backgroundColor=UIColor.whiteColor()
        globalUnitLength = ProjectWindow(CGRectGetMaxX(self.frame),
                                         WY: CGRectGetMaxY(self.frame),TX: 16,TY: 10)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}
