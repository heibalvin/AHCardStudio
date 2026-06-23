//
//  AHKlondikeScene.swift
//  AHCardStudioApp
//
//  Created by Alvin HEIB on 23/06/2026.
//

import SpriteKit

// A simple game scene with falling boxes
class AHKlondikeScene: SKScene {
    
    override init() {
        super.init(size: CGSize(width: 2048, height: 1536))
        self.anchorPoint = .zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        let playground = SKSpriteNode(imageNamed: "playing-card-board-2048x1536")
        playground.name = "playground"
        playground.size = CGSize(width: 2048, height: 1536)
        playground.anchorPoint = .zero
        playground.zPosition = -100
        addChild(playground)
        
        for id in 0...6 {
            let pile = SKSpriteNode(imageNamed: "cardBack_blue1")
            pile.name = "pile\(id)"
            pile.anchorPoint = .zero
            pile.position = CGPoint(x: 256 * id + 256, y: 1024)
            addChild(pile)
        }
    }

    #if os(ios)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        box.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
    #endif
    
    #if os(macos)
    override func mouseDown(with event: NSEvent) {
        let location = event.locationInWindow
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
    #endif
}
