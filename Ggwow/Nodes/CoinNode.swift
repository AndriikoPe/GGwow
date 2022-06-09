//
//  CoinNode.swift
//  Ggwow
//
//  Created by user1 on 08.06.2022.
//

import SpriteKit

class CoinNode: SKSpriteNode {
    private let radius: CGFloat
    private var timeToLive: Int
    private var label: SKLabelNode?
    
    init(radius: CGFloat, life: Int) {
        self.radius = radius
        self.timeToLive = life
        super.init(
            texture: nil,
            color: .clear,
            size: CGSize(width: radius * 2, height: radius * 2)
        )
        
        setupCoin()
        setupCountdownLabel()
        setupPhysics()
    }
    
    private func setupCountdownLabel() {
        label = SKLabelNode(fontNamed: "Helvetica Bold")
        guard let label = label else { return }
        label.fontSize = radius / 2
        label.zPosition = 30
        label.verticalAlignmentMode = .center
        setupLabelText()
        addChild(label)
        
        startCountdown()
    }
    
    private func startCountdown() {
        let pause = SKAction.wait(forDuration: 1)
        let countdown = SKAction.sequence([pause, SKAction.run(countOneSecond)])
        run(SKAction.repeat(countdown, count: timeToLive)) { [weak self] in
            self?.removeFromParent()
        }
    }
    
    private func countOneSecond() {
        timeToLive -= 1
        setupLabelText()
    }
    
    private func setupLabelText() {
        label?.text = "\(timeToLive)"
        label?.fontColor = timeToLive < 4 ? .red : .black
    }
    
    private func setupCoin() {
        let texture = SKTexture(imageNamed: "coin")
        let coin = SKSpriteNode(texture: texture, size: size)
        coin.zPosition = 20
        
        addChild(coin)
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        physicsBody?.pinned = true
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = Collisions.coin.rawValue
        physicsBody?.contactTestBitMask = Collisions.ball.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
