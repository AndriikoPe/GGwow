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
        super.init(texture: nil, color: .clear, size:
                    CGSize(width: radius * 2, height: radius * 2))
        
        let texture = SKTexture(imageNamed: "shield")
        let ball = SKSpriteNode(texture: texture, size: size)
        ball.zPosition = 20
        addChild(ball)
        
        if enabled { enable() }
    }
    
    func enable() {
        guard !isActivated else { return }
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2.0)
        physicsBody?.categoryBitMask = Collisions.ball.rawValue
        physicsBody?.collisionBitMask = Collisions.umbrella.rawValue | Collisions.wall.rawValue
        physicsBody?.contactTestBitMask = Collisions.umbrella.rawValue | Collisions.wall.rawValue |  Collisions.ground.rawValue | Collisions.coin.rawValue
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.mass = 0.01
        
        addSparks()
        
        physicsBody?.applyImpulse(
            CGVector(dx: CGFloat.random(in: -5...5),  dy: 10)
        )
        run(Sounds.launch)
    }
    
    private func addSparks() {
        guard let sparks = SKEmitterNode(fileNamed: "SparkParticle") else { return }
        sparks.zPosition = 10
        sparks.targetNode = scene
        addChild(sparks)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
