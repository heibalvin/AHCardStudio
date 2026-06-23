//
//  AHKlondikeGameView.swift
//  AHCardStudioApp
//
//  Created by Alvin HEIB on 23/06/2026.
//

import SwiftUI
import SpriteKit

// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points
struct AHKlondikeSceneView: View {
    var scene = AHKlondikeScene()
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(maxWidth: scene.frame.width, maxHeight: scene.frame.height) // Constrains the SwiftUI container
            .padding()
    }
}
