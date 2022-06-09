//
//  GameScene.swift
//  Ggwow
//
//  Created by user1 on 07.06.2022.
//

import SpriteKit

class GameScene: SKScene {
    private var umbrellaNode: UmbrellaNode!
    private var ballNode: BallNode!
    
    private let minDX: CGFloat = 0.1
    private let ballRadius: CGFloat = 30.0
    private let umbrellaSize = CGSize(width: 80, height: 80)
    
    private var lastTouchX: CGFloat = 0.0
    
    private var umbrellaPositionRange: ClosedRange<CGFloat> {
        (umbrellaSize.width / 2)...(size.width - (umbrellaSize.width / 2))
    }
    
    override func didMove(to view: SKView) {
        setupBackground()
        physicsWorld.contactDelegate = self
        
        let centerX = size.width / 2
        
        umbrellaNode = UmbrellaNode(umbrellaSize)
        umbrellaNode.position = CGPoint(x: centerX, y: umbrellaSize.height + 20)
        
        ballNode = BallNode(radius: ballRadius)
        ballNode.position = CGPoint(x: centerX, y: size.height / 2)
        setupBoundaries()
        
        addChild(umbrellaNode)
        addChild(ballNode)
    }
    
    private func setupBackground() {
        let texture = SKTexture(imageNamed: "background")
        let background = SKSpriteNode(texture: texture, size: size)
        
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        
        addChild(background)
    }
    
    private func setupBoundaries() {
        let centerY = size.height / 2
        let centerX = size.width / 2
        
        let leftWall = WallNode(
            at: CGPoint(x: 10, y: centerY),
            CGSize(width: 20, height: size.height)
        )
        
        let topInset = view!.safeAreaInsets.top
        let topWall = WallNode(
            at: CGPoint(x: centerX, y: size.height),
            CGSize(width: size.width, height: 20 + 2 * topInset)
        )
        let rightWall = WallNode(
            at: CGPoint(x: size.width - 10, y: centerY),
            CGSize(width: 20, height: size.height)
        )
        
        let ground = GroundNode(
            at: CGPoint(x: centerX, y: 10),
            CGSize(width: size.width, height: 20)
        )
        ground.zPosition = 1
        
        addChild(leftWall)
        addChild(topWall)
        addChild(rightWall)
        addChild(ground)
    }
    
    // MARK: - Touches.
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        lastTouchX = touch.location(in: self).x
        if ballNode.isActivated { setUmbrellaXPosition(to: touch.location(in: self).x) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if ballNode.isActivated {
            setUmbrellaXPosition(to: touch.location(in: self).x)
        } else {
            ballNode.enable()
            startCoinSpawner()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let newX = touch.location(in: self).x
        if abs(newX - lastTouchX) > minDX {
            lastTouchX = newX
            setUmbrellaXPosition(to: newX)
        }
    }
    
    private func setUmbrellaXPosition(to newX: CGFloat) {
        if umbrellaPositionRange ~= newX {
            umbrellaNode.position.x = newX
        }
    }
    
    // MARK: - Coins.
    
    private func startCoinSpawner() {
        let coinSpawner = SKAction.sequence([.wait(forDuration: 5), .run(spawnCoins)])
        run(SKAction.repeatForever(coinSpawner))
    }
    
    private func spawnCoins() {
        for _ in 0...Int.random(in: 2...5) {
            let coin = CoinNode(radius: 30, life: Int.random(in: 5...8))
            let x = CGFloat.random(in: 50...(size.width - 50))
            let y = CGFloat.random(
                in: (umbrellaSize.height + 50)...(size.height - 50 - (view?.safeAreaInsets.top ?? 0))
            )
            coin.position = CGPoint(x: x, y: y)
            self.addChild(coin)
        }
    }
    
    // MARK: - Lose.
    
    func lose() {
        let loseScene = LoseGameScene(size: size)
        view?.presentScene(loseScene, transition: .fade(withDuration: 1))
    }
}
