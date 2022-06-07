//
//  BallNode.swift
//  Ggwow
//
//  Created by user1 on 07.06.2022.
//

import SpriteKit

class BallNode: SKSpriteNode {
    
    
    init(radius: CGFloat, enabled: Bool = false) {
        super.init(texture: nil, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        
        let ball = SKShapeNode(circleOfRadius: radius)
        ball.fillColor = .systemBlue
        ball.strokeColor = .systemBlue
        addChild(ball)
        
        if enabled { enable() }
    }
    
    func enable() {
        // If physicsBody is enabled, consider ball already enabled.
        guard physicsBody == nil else { return }
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2.0)
        physicsBody?.categoryBitMask = Collisions.ball.rawValue
        physicsBody?.collisionBitMask = Collisions.umbrella.rawValue | Collisions.wall.rawValue
        physicsBody?.contactTestBitMask = Collisions.ground.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
