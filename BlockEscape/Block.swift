//
//  Block.swift
//  BlockEscape
//
//  Created by Payton McBurney on 11/20/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

import SpriteKit

// Source for adding sprites programmatically https://www.raywenderlich.com/71-spritekit-tutorial-for-beginners
// Source for randomly dropped items https://stackoverflow.com/questions/38601447/spawn-nodes-randomly
class Block: SKSpriteNode {
    init(playerY: CGFloat) {
        super.init(texture: nil, color: SKColor.clear, size: CGSize.zero)
        self.name = "block"
        setRandomColor()
        setRandomSize()
        setRandomPosition(blockY: playerY + 1200)
        createPhysicsBody()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRandomColor() {
        let red: CGFloat = CGFloat.random(in: 0 ... 1)
        let green: CGFloat = CGFloat.random(in: 0 ... 1)
        let blue: CGFloat = CGFloat.random(in: 0 ... 1)
        self.color = SKColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func setRandomSize() {
        let width: CGFloat = CGFloat.random(in: 50 ... 250)
        let height: CGFloat = CGFloat.random(in: 50 ... 100)
        self.size = CGSize(width: width, height: height)
    }
    
    private func setRandomPosition(blockY: CGFloat) {
        let blockX: CGFloat = CGFloat.random(in: -150 ... 150)
        self.position = CGPoint(x: blockX, y: blockY)
    }
    
    private func createPhysicsBody() {
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody.affectedByGravity = true
        physicsBody.isDynamic = true
        physicsBody.allowsRotation = true
        physicsBody.pinned = false
        physicsBody.restitution = 0.0
        physicsBody.linearDamping = 1.0
        self.physicsBody = physicsBody
    }
}
