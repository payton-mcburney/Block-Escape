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
    var floor: SKSpriteNode!
    private var playerCanJump: Bool!
    
    override func didMove(to view: SKView) {
        // SOURCE: https://www.raywenderlich.com/71-spritekit-tutorial-for-beginners
        
        // Testing for future collision development
        print("scene started")
        
        
        //Gameplay background
        backgroundColor = SKColor.white
        
        // Initialize floor
        guard let floor = childNode(withName: "floor") as? SKSpriteNode else {
            fatalError("floor node not loaded")
        }
        self.floor = floor
        
        // Initialize player
        guard let player = childNode(withName: "player") as? SKSpriteNode else {
            fatalError("player node not loaded")
        }
        self.player = player
        physicsWorld.contactDelegate = self
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        playerCanJump = false
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        // Player jumps if the user taps the screen under the floor
        if (playerCanJump && pos.y < floor.position.y) {
            print("Jump!")
//            let moveUp = SKAction.moveBy(x: 0, y: 500, duration: 1.0)
//            player.run(moveUp)
            player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 250.0))
            playerCanJump = false
        }
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
            // Move the player if the user moves their finger above the floor
            if (touchLocation.y > floor.position.y) {
                player.position.x = touchLocation.x
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // SOURCE: https://www.hackingwithswift.com/read/11/5/collision-detection-skphysicscontactdelegate
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" {
            collisionBetween(player: contact.bodyA.node!, object: contact.bodyB.node!, pointOfCollision: contact.contactPoint)
        } else if contact.bodyB.node?.name == "player" {
            collisionBetween(player: contact.bodyB.node!, object: contact.bodyA.node!, pointOfCollision: contact.contactPoint)
        }
    }
    
    func collisionBetween(player: SKNode, object: SKNode, pointOfCollision: CGPoint) {
        if(object.name == "floor" && pointOfCollision.y < player.position.y) {
            playerCanJump = true
            print("collision detected with floor")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
