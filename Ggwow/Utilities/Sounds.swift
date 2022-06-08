//
//  Sounds.swift
//  Ggwow
//
//  Created by user1 on 08.06.2022.
//

import SpriteKit

struct Sounds {
    static var impactWall: SKAction {
        allWallImpacts.randomElement()!
    }
    
    static var impactUmbrella: SKAction {
        allUmbrellaImpacts.randomElement()!
    }
    
    static let launch = SKAction.playSoundFileNamed(
        "launch", waitForCompletion: false
    )
    
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
