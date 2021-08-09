//
//  File.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 7/27/21.
//

//An extensions by GlowingSprite.swift on Github that allows for glow to be put behind a texture
import SpriteKit

extension SKSpriteNode {
    /// Initializes a textured sprite with a glow using an existing texture object.
    convenience init(texture: SKTexture, glowRadius: CGFloat) {
        self.init(texture: texture, color: .clear, size: texture.size())
        
        let glow: SKEffectNode = {
            let glow = SKEffectNode()
            glow.addChild(SKSpriteNode(texture: texture))
            glow.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": glowRadius])
            glow.shouldRasterize = true
            return glow
        }()
        
        let glowRoot: SKNode = {
            let node = SKNode()
            node.name = "Glow"
            node.zPosition = -1
            return node
        }()
        
        glowRoot.addChild(glow)
        addChild(glowRoot)
    }
}
