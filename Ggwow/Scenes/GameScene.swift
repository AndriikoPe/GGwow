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
    private let umbrellaSize = CGSize(width: 60, height: 60)
    
    private var lastTouchX: CGFloat = 0.0
    private var ballActivated = false
    
    private var umbrellaPositionRange: ClosedRange<CGFloat> {
        (umbrellaSize.width / 2)...(size.width - (umbrellaSize.width / 2))
    }
    
    override func didMove(to view: SKView) {
        umbrellaNode = UmbrellaNode(umbrellaSize)
        let centerX = size.width / 2
        print("Width is \(size.width), centerX = \(centerX)")
        umbrellaNode.position = CGPoint(x: centerX, y: umbrellaSize.height + 20)
        
        ballNode = BallNode(radius: ballRadius)
        ballNode.position = CGPoint(x: centerX, y: size.height / 2)
        
        addChild(umbrellaNode)
        addChild(ballNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        lastTouchX = touch.location(in: self).x
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if ballActivated {
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
