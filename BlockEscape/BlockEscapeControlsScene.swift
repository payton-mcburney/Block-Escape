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
class BlockEscapeControlsScene: SKScene
{
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
    
    override func didMove(to view: SKView) {
        
        // Gameplay background
        backgroundColor = SKColor.clear
        
        // Initialize buttons
        // SOURCE: https://stackoverflow.com/questions/40294942/how-do-i-use-sks-skspritenode-in-gamescene
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
}
