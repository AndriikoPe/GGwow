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
    private let ballRadius: CGFloat = 20.0
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
        setupWalls()
        
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
    
    private func setupWalls() {
        let centerY = size.height / 2
        let leftWall = WallNode(
            at: CGPoint(x: 10, y: centerY),
            CGSize(width: 20, height: size.height)
        )
        
        let topInset = view!.safeAreaInsets.top
        let topWall = WallNode(
            at: CGPoint(x: size.width / 2, y: size.height),
            CGSize(width: size.width, height: 20 + 2 * topInset)
        )
        let rightWall = WallNode(
            at: CGPoint(x: size.width - 10, y: centerY),
            CGSize(width: 20, height: size.height)
        )
        
        addChild(leftWall)
        addChild(topWall)
        addChild(rightWall)
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
}
