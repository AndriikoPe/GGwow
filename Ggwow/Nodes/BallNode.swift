//
//  BallNode.swift
//  Ggwow
//
//  Created by user1 on 07.06.2022.
//

import SpriteKit

class BallNode: SKSpriteNode {
    var isActivated: Bool {
        physicsBody != nil
    }
    
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
        guard !isActivated else { return }
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2.0)
        physicsBody?.categoryBitMask = Collisions.ball.rawValue
        physicsBody?.collisionBitMask = Collisions.umbrella.rawValue | Collisions.wall.rawValue
        physicsBody?.contactTestBitMask = Collisions.umbrella.rawValue | Collisions.wall.rawValue | Collisions.ground.rawValue
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.mass = 0.01
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
