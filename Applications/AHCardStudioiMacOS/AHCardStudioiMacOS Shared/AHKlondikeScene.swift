//
//  AHKlondikeScene.swift
//  AHCardStudioiMacOS
//
//  Created by Alvin HEIB on 20/06/2026.
//

import SpriteKit

class AHKlondikeScene: SKScene {
    var game = AHKlondike()
    
    class func newGameScene() -> AHKlondikeScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "AHKlondikeScene") as? AHKlondikeScene else {
            print("Failed to load AHKlondikeScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFit
        
        return scene
    }
    
    
}
