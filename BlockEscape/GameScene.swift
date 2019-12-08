//
//  GameScene.swift
//  BlockEscape
//
//  Created by Payton McBurney on 11/11/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let cameraNode = SKCameraNode()
    var player: Player!
    var controls: GameControls!
    var leftWall: SKSpriteNode!
    var rightWall: SKSpriteNode!
    var leftWallScale: CGFloat!
    var rightWallScale: CGFloat!
    private var blockSpawning: Bool! = false
    
    var healthDisplay: SKLabelNode!
    var scoreDisplay: SKLabelNode!
    
    
    var positions: [CGPoint]! = [CGPoint]()
    var myHero: SKSpriteNode!

    
    override func didMove(to view: SKView) {
        // Gameplay background
        backgroundColor = SKColor.white

        // Initialize player
        player = Player()
        self.addChild(player)
        physicsWorld.contactDelegate = self
        player.physicsBody!.contactTestBitMask = player.physicsBody!.collisionBitMask
        
        // Initialize controls
        controls = GameControls(player: player, scene: self)
        
        // Initialize health and score labels
        guard let healthDisplay = childNode(withName: "health") as? SKLabelNode else {
            fatalError("Health display node not loaded!")
        }
        self.healthDisplay = healthDisplay
        
        guard let scoreDisplay = childNode(withName: "score") as? SKLabelNode else {
            fatalError("Score display node not loaded!")
        }
        self.scoreDisplay = scoreDisplay
        
        // Initialize walls
        guard let leftWall = childNode(withName: "left_wall") as? SKSpriteNode else {
            fatalError("Left wall node not loaded!")
        }
        leftWallScale = leftWall.xScale
        self.leftWall = leftWall
        
        guard let rightWall = childNode(withName: "right_wall") as? SKSpriteNode else {
            fatalError("Right wall node not loaded!")
        }
        rightWallScale = rightWall.xScale
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        controls.handleButtonPressBegin(touchedNode: touchedNode)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controls.handleButtonPressEnd()
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
            player.takeDamage(damage: 70)
        }
        
        if player.isDead() {
            print("You dead")
            
            // SOURCE: https://medium.com/aviabird/the-one-with-userdefaults-aab2c2a7e170
            // Stores the current score to the scoreboard
            if var scores = UserDefaults.standard.object(forKey: "scores") as? Array<Int> {
                scores.append(player.getScore())
                UserDefaults.standard.set(scores, forKey: "scores")
            }
            else {
                var scores = [Int]()
                scores.append(player.getScore())
                UserDefaults.standard.set(scores, forKey: "scores")
            }
//            physicsWorld.gravity = .zero
//            player.freeze()
//            for node in self.children as [SKNode] {
//                node.isPaused = false
//            }
    }
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        // Handle horizontal player movement
        controls.handlePlayerMovement()
        
        // Update score and health displays
        player.updateScore()
        healthDisplay.text = "Health: \(player.getHealth())"
        healthDisplay.fontColor = UIColor.black
        scoreDisplay.text = "Score: \(player.getScore())"
        scoreDisplay.fontColor = UIColor.black
        
        // Set camera, button, and label positions based on player position
        cameraNode.position = CGPoint(x: cameraNode.position.x, y: player.position.y + 240)
        controls.updateButtonPositions()
        healthDisplay.position = CGPoint(x: healthDisplay.position.x, y: cameraNode.position.y + 510)
        scoreDisplay.position = CGPoint(x: scoreDisplay.position.x, y: cameraNode.position.y + 560)
        
        // Set wall height and position based on the highest vertical point the player has reached
        leftWall.xScale = leftWallScale * ((player.getMaxHeight() + 1240) / 1000)
        leftWall.position = CGPoint(x: leftWall.position.x, y: leftWall.size.width / 2 - 325)
        rightWall.xScale = rightWallScale * ((player.getMaxHeight() + 1240) / 1000)
        rightWall.position = CGPoint(x: rightWall.position.x, y: rightWall.size.width / 2 - 325)
        
        SpawnBlock()
    }
    
    // Spawns blocks randomly every five seconds
    private func SpawnBlock() {
        if !blockSpawning {
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
