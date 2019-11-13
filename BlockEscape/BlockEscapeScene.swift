//
//  BlockEscapeScene.swift
//  BlockEscape
//
//  Created by Payton McBurney on 11/11/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

import SpriteKit
import GameplayKit

class BlockEscapeScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        // SOURCE: https://www.raywenderlich.com/71-spritekit-tutorial-for-beginners
        
        // Testing for future collision development
        print("scene started")
        
        //Gameplay background
        backgroundColor = SKColor.white
        
        // Initialize player
        guard let player = childNode(withName: "player_name") as? SKSpriteNode else {
            fatalError("player node not loaded")
        }
        self.player = player
        
//        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.1)
//        player.size = CGSize(width: player.size.width * 0.1, height: player.size.height * 0.1)
//        addChild(player)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let moveUp = SKAction.moveBy(x: 0, y: 250, duration: 1.5)
        player.run(moveUp)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let touchLocation = touch.location(in: self)
            player.position.x = touchLocation.x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func collisionBetween(object1: SKNode, object2: SKNode) {
        print("collision detected")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
