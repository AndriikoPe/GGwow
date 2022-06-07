//
//  UmbrellaNode.swift
//  Ggwow
//
//  Created by user1 on 07.06.2022.
//

import SpriteKit

class UmbrellaNode: SKSpriteNode {
    init(_ size: CGSize) {
        let umbrellaTexture = SKTexture(imageNamed: "umbrella")
        super.init(texture: umbrellaTexture, color: .clear, size: size)
        
        physicsBody = SKPhysicsBody(texture: umbrellaTexture, size: size)
        physicsBody?.categoryBitMask = Collisions.umbrella.rawValue
        physicsBody?.collisionBitMask = Collisions.ball.rawValue
        
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
