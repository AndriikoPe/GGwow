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
        
    }
}
