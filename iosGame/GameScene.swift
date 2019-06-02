//
//  GameScene.swift
//  iosGame
//
//  Created by Chris Lee on 01/06/2019.
//  Copyright © 2019 ChrisLee0727. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var locker = SKSpriteNode()
    var player = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        locker = SKSpriteNode(imageNamed: "Locker")
        locker.size = CGSize(width: 300, height: 300)
        locker.position = CGPoint(x: CGRect.midX(self.frame), y: CGRect.midY(self.frame))
        self.addChild(locker)
        
        player = SKSpriteNode(imageNamed: "Player")
        player.size = CGSize(width: 40, height: 7)
        player.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 112)
        player.zRotation
        
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
