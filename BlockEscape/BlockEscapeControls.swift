//
//  BlockEscapeControlsScene.swift
//  BlockEscape
//
//  Created by Payton McBurney on 11/15/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

import SpriteKit
import GameplayKit

//SOURCE: https://stackoverflow.com/questions/41108878/how-to-control-scenekit-character-movement-with-skspritenode/41148410
class BlockEscapeControls {
    private var player: Player!
    private var jumpButton: SKSpriteNode!
    private var leftButton: SKSpriteNode!
    private var rightButton: SKSpriteNode!
    private var jumpButtonScale: CGFloat!
    private var leftButtonScale: CGFloat!
    private var rightButtonScale: CGFloat!
    private var jumpButtonPressed: Bool!
    private var leftButtonPressed: Bool!
    private var rightButtonPressed: Bool!
    
    init(player: Player, scene: SKScene) {
        self.player = player
        
        // Initialize buttons
        // SOURCE: https://stackoverflow.com/questions/40294942/how-do-i-use-sks-skspritenode-in-gamescene
        guard let jumpButton = scene.childNode(withName: "jump_button") as? SKSpriteNode else {
            fatalError("Jump button node not loaded!")
        }
        jumpButtonScale = jumpButton.xScale
        self.jumpButton = jumpButton
        jumpButtonPressed = false
        
        guard let leftButton = scene.childNode(withName: "left_button") as? SKSpriteNode else {
            fatalError("Left button node not loaded!")
        }
        leftButtonScale = leftButton.xScale
        self.leftButton = leftButton
        leftButtonPressed = false
        
        guard let rightButton = scene.childNode(withName: "right_button") as? SKSpriteNode else {
            fatalError("Right button node not loaded!")
        }
        rightButtonScale = rightButton.xScale
        self.rightButton = rightButton
        rightButtonPressed = false
    }
    
    // Called when the player taps on one of the buttons
    func handleButtonPressBegin(touchedNode: SKNode) {
        //SOURCE: https://stackoverflow.com/questions/27922198/how-do-i-detect-if-an-skspritenode-has-been-touched
        if let name = touchedNode.name {
            if name == "left_button" {
                print("Start moving left")
                touchedNode.setScale(0.95 * leftButtonScale)
                leftButtonPressed = true
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
    
    // Called when the player stops tapping on one of the buttons
    func handleButtonPressEnd() {
        if leftButtonPressed {
            print("Stop moving left")
            leftButtonPressed = false
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
    
    // Handle horizontal player movement
    func handlePlayerMovement() {
        if leftButtonPressed {
            player.moveLeft()
        }
        if rightButtonPressed {
            player.moveRight()
        }
    }
    
    // Moves the buttons in relation to the player
    func updateButtonPositions() {
        leftButton.position = CGPoint(x: leftButton.position.x, y: player.position.y - 300)
        rightButton.position = CGPoint(x: rightButton.position.x, y: player.position.y - 300)
        jumpButton.position = CGPoint(x: jumpButton.position.x, y: player.position.y - 300)
    }
}
