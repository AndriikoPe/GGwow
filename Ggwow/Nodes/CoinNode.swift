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
    }
    
    private func setupCountdownLabel() {
        label = SKLabelNode(fontNamed: "HelveticaNeue")
        guard let label = label else { return }
        label.fontSize = radius
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
        label?.fontColor = timeToLive < 4 ? .red : .white
    }
    
    private func setupCoin() {
        let coin = SKShapeNode(circleOfRadius: radius)
        coin.strokeColor = .systemYellow
        coin.fillColor = .systemYellow
        coin.zPosition = 20
        
        addChild(coin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
