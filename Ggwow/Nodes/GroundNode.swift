//
//  GroundNode.swift
//  Ggwow
//
//  Created by user1 on 09.06.2022.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    init(at position: CGPoint, _ size: CGSize) {
        let texture = SKTexture(imageNamed: "spruce")
        super.init(texture: texture, color: .clear, size: size)
        self.position = position
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.pinned = true
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = Collisions.ground.rawValue
        physicsBody?.contactTestBitMask = Collisions.ball.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
