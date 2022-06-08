//
//  CollisionsDelegation.swift
//  Ggwow
//
//  Created by user1 on 07.06.2022.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let (ball, other) = contact.bodyA.categoryBitMask <
            contact.bodyB.categoryBitMask ?
        (contact.bodyA, contact.bodyB) : (contact.bodyB, contact.bodyA)

        switch contactMask {
        case ContactType.ballUmbrella.rawValue:
            ballUmbrella(ball, other)
        case ContactType.ballWall.rawValue:
            ballWall(ball, other)
        case ContactType.ballGround.rawValue:
            ballGround(ball, other)
        default: break
        }
    }
    
    private func ballUmbrella(_ ball: SKPhysicsBody, _ umbrella: SKPhysicsBody) {

    }
    
    private func ballWall(_ ball: SKPhysicsBody, _ wall: SKPhysicsBody) {
        
    }
    
    private func ballGround(_ ball: SKPhysicsBody, _ ground: SKPhysicsBody) {
        
    }
}
