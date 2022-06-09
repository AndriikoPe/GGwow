//
//  Sounds.swift
//  Ggwow
//
//  Created by user1 on 08.06.2022.
//

import SpriteKit

struct Sounds {
    // MARK: - Sound actions.
    
    static var impactWall: SKAction {
        allWallImpacts.randomElement()!
    }
    
    static var impactUmbrella: SKAction {
        allUmbrellaImpacts.randomElement()!
    }
    
    static let coin = SKAction.playSoundFileNamed(
        "coin", waitForCompletion: false
    )
    
    static let launch = SKAction.playSoundFileNamed(
        "launch", waitForCompletion: false
    )
    
    // MARK: - Collections of sounds.
    
    private static let allWallImpacts = (1...5).map {
        SKAction.playSoundFileNamed(
            "impact\($0)", waitForCompletion: false
        )
    }
    
    private static let allUmbrellaImpacts = (1...5).map {
        SKAction.playSoundFileNamed(
            "umbrellaImpact\($0)", waitForCompletion: false
        )
    }
}
