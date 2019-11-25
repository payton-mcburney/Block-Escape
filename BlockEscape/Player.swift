//
//  Player.swift
//  BlockEscape
//
//  Created by Payton McBurney on 11/20/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//
// SOURCE: https://stackoverflow.com/questions/25397672/make-skspritenode-subclass-using-swift

import SpriteKit

class Player: SKSpriteNode
{
    private var canJump: Bool!
    private let moveSpeed: CGFloat = 7.0
    private let jumpHeight: CGFloat = 400.0
    
    init()
    {
        let texture = SKTexture(imageNamed: "player.png")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 100, height: 140))
        self.name = "player"
        self.position = CGPoint(x: 0, y: -240)
        createPhysicsBody()
        
        canJump = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createPhysicsBody()
    {
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody.affectedByGravity = true
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = false
        physicsBody.pinned = false
        physicsBody.restitution = 0.0
        self.physicsBody = physicsBody
    }
    
    func moveLeft()
    {
        self.position.x -= moveSpeed
    }
    
    func moveRight()
    {
        self.position.x += moveSpeed
    }
    
    func jump()
    {
        if canJump
        {
            self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: jumpHeight))
            canJump = false
        }
    }
    
    func landed()
    {
        canJump = true
    }
}
