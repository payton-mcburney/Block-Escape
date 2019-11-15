//
//  BlockEscapeControlsScene.swift
//  BlockEscape
//
//  Created by Payton McBurney on 11/15/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

//import SpriteKit
//import GameplayKit
//
////SOURCE: https://stackoverflow.com/questions/41108878/how-to-control-scenekit-character-movement-with-skspritenode/41148410
//class BlockEscapeControlsScene: SKScene {
//    var player: SKSpriteNode
//    var leftButton: SKSpriteNode
//    var rightButton: SKSpriteNode
//    var jumpButton: SKSpriteNode
//    var leftButtonGestureRecognizer: UIGestureRecognizer
//    var rightButtonGestureRecognizer: UIGestureRecognizer
//    var jumpButtonGestureRecognizer: UIGestureRecognizer
//
//    init(player: SKSpriteNode) {
//        self.player = player
//        super.init()
//    }
//    
//    override func didMove(to:SKView) {
//        // add an SKSpriteNode for the play button
//        self.leftButton = SKSpriteNode(imageNamed:"leftButton")
//        self.leftButton.position = CGPoint(x: 50, y: 50)
//        self.leftButtonGestureRecognizer = // add a UIGestureRecognizer with selector as handlePlayButtonTap
//            self.view.addGestureRecognizer(self.leftButtonGestureRecognizer)
//    }
//    
//    // gesture recognizer to handle play button tap
//    func handlePlayButtonTap() {
//        //in here move your character
//    }
//}
