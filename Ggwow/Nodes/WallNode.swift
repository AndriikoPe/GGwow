//
//  WallNode.swift
//  Ggwow
//
//  Created by user1 on 08.06.2022.
//

import SpriteKit

class WallNode: SKSpriteNode {
    init(at position: CGPoint, _ size: CGSize) {
        let birchTexture = SKTexture(imageNamed: "birch")
        super.init(texture: birchTexture, color: .systemGray, size: size)
        self.position = position
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.pinned = true
        physicsBody?.allowsRotation = false
        physicsBody?.isDynamic = false
        physicsBody?.restitution = 0.5
        
        physicsBody?.categoryBitMask = Collisions.wall.rawValue
        physicsBody?.collisionBitMask = Collisions.ball.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
