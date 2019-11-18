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
    var jumpButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var jumpButtonScale: CGFloat!
    var leftButtonScale: CGFloat!
    var rightButtonScale: CGFloat!
    private var playerCanJump: Bool!
    private var playerMoveLeft: Bool!
    private var playerMoveRight: Bool!
    private var playerJumped: Bool!
    private let playerSpeed: CGFloat = 7.0
    private let jumpHeight: CGFloat = 400.0
    
    override func didMove(to view: SKView) {
        // SOURCE: https://www.raywenderlich.com/71-spritekit-tutorial-for-beginners for adding sprites programmatically
        
        // Gameplay background
        backgroundColor = SKColor.white
        
        
        // Initialize floor
        // SOURCE: https://stackoverflow.com/questions/40294942/how-do-i-use-sks-skspritenode-in-gamescene
        guard let floor = childNode(withName: "floor") as? SKSpriteNode else {
            fatalError("Floor node not loaded!")
        }
        self.floor = floor
        
        // Initialize player
        guard let player = childNode(withName: "player") as? SKSpriteNode else {
            fatalError("Player node not loaded!")
        }
        self.player = player
        physicsWorld.contactDelegate = self
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        playerCanJump = false
        playerJumped = false
        playerMoveLeft = false
        playerMoveRight = false
        
        // Initialize buttons
        guard let jumpButton = childNode(withName: "jump_button") as? SKSpriteNode else {
            fatalError("Jump button node not loaded!")
        }
        jumpButtonScale = jumpButton.xScale;
        self.jumpButton = jumpButton
        
        guard let leftButton = childNode(withName: "left_button") as? SKSpriteNode else {
            fatalError("Left button node not loaded!")
        }
        leftButtonScale = leftButton.xScale;
        self.leftButton = leftButton
        
        guard let rightButton = childNode(withName: "right_button") as? SKSpriteNode else {
            fatalError("Right button node not loaded!")
        }
        rightButtonScale = rightButton.xScale;
        self.rightButton = rightButton
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        // Player jumps if the user taps the screen under the floor
//        if (playerCanJump && pos.y < floor.position.y) {
//            print("Jump!")
//            player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 250.0))
//            playerCanJump = false
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        //SOURCE: https://stackoverflow.com/questions/27922198/how-do-i-detect-if-an-skspritenode-has-been-touched
        if let name = touchedNode.name {
            if name == "left_button" {
                print("Start moving left")
                touchedNode.setScale(0.95 * leftButtonScale)
                playerMoveLeft = true
            }
            
            if name == "right_button" {
                print("Start moving right")
                touchedNode.setScale(0.95 * rightButtonScale)
                playerMoveRight = true
            }
            
            if name == "jump_button" && playerCanJump {//&& player.physicsBody?.velocity.dy == 0.0 {
                print("Jump!")
                touchedNode.setScale(0.95 * jumpButtonScale)
                player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: jumpHeight))
                playerCanJump = false
                playerJumped = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches
//        {
//            let touchLocation = touch.location(in: self)
//            // Move the player if the user moves their finger above the floor
//            if (touchLocation.y > floor.position.y) {
//                player.position.x = touchLocation.x
//            }
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if playerMoveLeft {
            print("Stop moving left")
            playerMoveLeft = false
            leftButton.setScale(leftButtonScale)
        }
        
        if playerMoveRight {
            print("Stop moving right")
            playerMoveRight = false
            rightButton.setScale(rightButtonScale)
        }
        
        if playerJumped {
            playerJumped = false
            jumpButton.setScale(jumpButtonScale)
        }
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
        if (object.name == "floor" || object.name == "block") && pointOfCollision.y <= player.position.y - 65.0 {
            playerCanJump = true
            print("collision detected with floor")
        }
        
        if object.name == "block" && pointOfCollision.y >= player.position.y + 65.0 {
            print("player crushed!")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if playerMoveLeft {
            player.position.x -= playerSpeed
        }
        if playerMoveRight {
            player.position.x += playerSpeed
        }
    }
}
