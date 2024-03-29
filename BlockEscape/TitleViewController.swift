//
//  TitleViewController.swift
//  BlockEscape
//
//  Created by DC Scott on 11/7/19.
//  Copyright © 2019 DC Scott. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'TitleScene.sks'
            if let scene = SKScene(fileNamed: "TitleScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func unwindFromGame(sender:
        UIStoryboardSegue)
    {
        
    }
    
    @IBAction func unwindFromScores(sender:
        UIStoryboardSegue)
    {
        
    }

    @IBAction func clearScoresOnClick(_ sender: Any) {
        let scores = [Int]()
        UserDefaults.standard.set(scores, forKey: "scores")
    }
    
}
