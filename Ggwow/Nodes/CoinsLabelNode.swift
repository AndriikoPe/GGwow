//
//  CoinsLabelNode.swift
//  Ggwow
//
//  Created by user1 on 09.06.2022.
//

import SpriteKit

class CoinsLabelNode: SKSpriteNode {
    private let label: SKLabelNode
    private var coin: SKSpriteNode?
    
    init(at position: CGPoint, _ size: CGSize) {
        self.label = SKLabelNode(fontNamed: "Helvetica Bold")
        
        super.init(texture: nil, color: .clear, size: size)
        self.position = position
        
        setupIcon()
        setupLabel()
    }
    
    func set(text: String) {
        label.text = text
    }
    
    private func setupIcon() {
        let texture = SKTexture(imageNamed: "coin")
        let coinSide = size.height * 0.7
        let coinSize = CGSize(width: coinSide, height: coinSide)
        coin = SKSpriteNode(texture: texture, size: coinSize)
        guard let coin = coin else { return }
        coin.zPosition = 50
        coin.position = CGPoint(x: coinSide / 2, y: size.height / 2)
        
        addChild(coin)
    }
    
    private func setupLabel() {
        label.fontSize = size.height / 2
        label.text = "0"
        label.verticalAlignmentMode = .center
        let x = (coin?.size.width ?? 0) + 10
        let y = size.height / 2
        label.position = CGPoint(x: x, y: y)
        label.zPosition = 60
        
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented.")
    }
}
