//
//  GameViewController.swift
//  AHCardStudioiMacOS macOS
//
//  Created by Alvin HEIB on 20/06/2026.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = AHKlondikeScene.newGameScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

}

