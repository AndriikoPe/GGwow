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

        switch contactMask {
        case ContactType.ballUmbrella.rawValue:
            ballUmbrella()
        case ContactType.ballWall.rawValue:
            ballWall()
        case ContactType.ballGround.rawValue:
            ballGround()
        case ContactType.ballCoin.rawValue:
            ballCoin(contact.bodyA, contact.bodyB)
        default: break
        }
    }
    
    private func ballUmbrella() {
        run(Sounds.impactUmbrella)
    }
    
    private func ballWall() {
        run(Sounds.impactWall)
    }
    
    private func ballGround() {
        lose()
    }
    
    private func ballCoin(_ bodyA: SKPhysicsBody, _ bodyB: SKPhysicsBody) {
        if let coin = bodyA.node as? CoinNode {
            coin.removeFromParent()
        } else if let coin = bodyB.node as? CoinNode {
            coin.removeFromParent()
        }
    }
}
