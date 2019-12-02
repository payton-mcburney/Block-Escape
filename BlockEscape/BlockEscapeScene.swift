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
    
    let cameraNode = SKCameraNode()
    var player: Player!
    var maxPlayerHeight: CGFloat!
    var leftWall: SKSpriteNode!
    var rightWall: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var jumpButtonScale: CGFloat!
    var leftButtonScale: CGFloat!
    var rightButtonScale: CGFloat!
    private var jumpButtonPressed: Bool!
    private var leftButonPressed: Bool!
    private var rightButtonPressed: Bool!
    private var blockSpawning: Bool! = false
    var playerHealth = 100
    
    
    var positions: [CGPoint]! = [CGPoint]()
    var myHero: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        // SOURCE: https://www.raywenderlich.com/71-spritekit-tutorial-for-beginners for adding sprites programmatically
        
        // Gameplay background
        backgroundColor = SKColor.white

        //var gravity: CGVector { get set }
        
        // Initialize player
        player = Player()
        self.addChild(player)
        physicsWorld.contactDelegate = self
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        maxPlayerHeight = player.position.y
        
        // Initialize buttons
        // SOURCE: https://stackoverflow.com/questions/40294942/how-do-i-use-sks-skspritenode-in-gamescene
        guard let jumpButton = childNode(withName: "jump_button") as? SKSpriteNode else {
            fatalError("Jump button node not loaded!")
        }
        jumpButtonScale = jumpButton.xScale;
        self.jumpButton = jumpButton
        jumpButtonPressed = false
        
        guard let leftButton = childNode(withName: "left_button") as? SKSpriteNode else {
            fatalError("Left button node not loaded!")
        }
        leftButtonScale = leftButton.xScale;
        self.leftButton = leftButton
        leftButonPressed = false
        
        guard let rightButton = childNode(withName: "right_button") as? SKSpriteNode else {
            fatalError("Right button node not loaded!")
        }
        rightButtonScale = rightButton.xScale;
        self.rightButton = rightButton
        rightButtonPressed = false
        
        // Initialize walls
        guard let leftWall = childNode(withName: "left_wall") as? SKSpriteNode else {
            fatalError("Left wall node not loaded!")
        }
        self.leftWall = leftWall
        
        guard let rightWall = childNode(withName: "right_wall") as? SKSpriteNode else {
            fatalError("Right wall node not loaded!")
        }
        self.rightWall = rightWall
        
        // Initialize camera
        // SOURCE: https://developer.apple.com/documentation/spritekit/skscene/1519696-camera
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        
        
//        let pos1 = CGPoint(x:50,y:400)
//        positions.append(pos1)
//        let pos2 = CGPoint(x:100,y:400)
//        positions.append(pos2)
//        let pos3 = CGPoint(x:200,y:400)
//        positions.append(pos3)
//        let pos4 = CGPoint(x:300,y:400)
//        positions.append(pos4)
//        let pos5 = CGPoint(x:400,y:400)
//        positions.append(pos5)
//        //... or : positions = [pos1,pos2,pos3...]
//        self.myHero = SKSpriteNode.init(color: .blue, size: CGSize(width: 50,height: 50))
//        self.myHero.alpha = 0.0
//        addChild(self.myHero)
//        spawn(count : 15)
    }
//    func spawn(count:Int) {
//        let generateRandom = SKAction.run({
//            let randomPosNum = randomNumber(range: 0...self.positions.count-1)
//            let randomTime = randomDouble(1.0, max: 3.0)
//            print("randomPos: \(randomPosNum) exit in randomTime:\(randomTime) ")
//            self.myHero.position = self.positions[randomPosNum]
//            self.runAction(SKAction.waitForDuration(randomTime))
//        })
//        let fadeIn = SKAction.fadeInWithDuration(0.5)
//        let fadeOut = SKAction.fadeOutWithDuration(0.0)
//        let fall = SKAction.moveToY(-30, duration: 0.5)
//        self.myHero.runAction(SKAction.repeatAction(SKAction.sequence([generateRandom,fadeIn,fall,fadeOut]), count: count))
//    }
//}
//func randomNumber(range: Range<Int> = 1...6) -> Int {
//    let min = range.startIndex
//    let max = range.endIndex
//    return Int(arc4random_uniform(UInt32(max - min))) + min
//}
//func randomDouble(min: Double, max: Double) -> Double {
//    return (Double(arc4random()) / Double(UINT32_MAX)) * (max - min) + min
//}
    
    
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
                leftButonPressed = true
            }
            
            if name == "right_button" {
                print("Start moving right")
                touchedNode.setScale(0.95 * rightButtonScale)
                rightButtonPressed = true
            }
            
            if name == "jump_button" {
                print("Jump!")
                touchedNode.setScale(0.95 * jumpButtonScale)
                player.jump()
                jumpButtonPressed = true
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
        if leftButonPressed {
            print("Stop moving left")
            leftButonPressed = false
            leftButton.setScale(leftButtonScale)
        }
        
        if rightButtonPressed {
            print("Stop moving right")
            rightButtonPressed = false
            rightButton.setScale(rightButtonScale)
        }
        
        if jumpButtonPressed {
            jumpButtonPressed = false
            jumpButton.setScale(jumpButtonScale)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // SOURCE: https://www.hackingwithswift.com/read/11/5/collision-detection-skphysicscontactdelegate
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "player" {
            handlePlayerCollision(object: contact.bodyB.node!, pointOfCollision: contact.contactPoint)
        } else if contact.bodyB.node?.name == "player" {
            handlePlayerCollision(object: contact.bodyA.node!, pointOfCollision: contact.contactPoint)
        }
    }
    
    func handlePlayerCollision(object: SKNode, pointOfCollision: CGPoint) {
        if (object.name == "floor" || object.name == "block") && pointOfCollision.y <= player.position.y - 65.0 {
            player.landed()
            print("collision detected with floor")
        }
        
        if object.name == "block" && pointOfCollision.y >= player.position.y + 65.0 {
            print("player crushed!")
            playerHealth -= 30
            print("player health \(playerHealth)")
        }
        
        //if playerHealth < 1 {
        //            let viewController: ScoresViewController = self.storyboard?.instantiateViewControllerWithIdentifier("VC") as ScoresViewController
        //            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        // Handle horizontal player movement
        if leftButonPressed {
            player.moveLeft()
        }
        if rightButtonPressed {
            player.moveRight()
        }
        
        // Find the largest y position the player has reached
        if maxPlayerHeight < player.position.y {
            maxPlayerHeight = player.position.y
        }
        
        // Set camera and button positions based on player position
        cameraNode.position = CGPoint(x: cameraNode.position.x, y: player.position.y + 240)
        leftButton.position = CGPoint(x: leftButton.position.x, y: cameraNode.position.y - 540)
        rightButton.position = CGPoint(x: rightButton.position.x, y: cameraNode.position.y - 540)
        jumpButton.position = CGPoint(x: jumpButton.position.x, y: cameraNode.position.y - 540)
        
        // Set wall height and position based on the highest vertical point the player has reached
//        leftWall.yScale = (maxPlayerHeight + 240) / 20
//        leftWall.position = CGPoint(x: leftWall.position.x, y: leftWall.size.width / 2 - 325)
//        rightWall.size = CGSize(width: maxPlayerHeight + 1500, height: 90)
//        rightWall.position = CGPoint(x: rightWall.position.x, y: rightWall.size.width / 2 - 325)
        
        SpawnBlock()
    }
    
    // Spawns blocks randomly every five seconds
    private func SpawnBlock()
    {
        if !blockSpawning
        {
            // SOURCE: https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { // Delay after 5 seconds
                let block: Block = Block(playerY: self.player.position.y)
                self.addChild(block)
                self.blockSpawning = false
            }
        }
        blockSpawning = true
    }
    
}
