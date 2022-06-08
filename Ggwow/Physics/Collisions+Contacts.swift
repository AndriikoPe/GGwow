//
//  Collisions.swift
//  Ggwow
//
//  Created by user1 on 07.06.2022.
//

import Foundation

enum Collisions: UInt32 {
    case ball = 1
    case umbrella = 2
    case wall = 4
    case ground = 8
}

enum ContactType: CaseIterable {
    case ballUmbrella
    case ballWall
    case ballGround
    
    // Bogus rawValue.
    var rawValue: UInt32 {
        switch self {
        case .ballUmbrella:
            return Collisions.ball.rawValue | Collisions.umbrella.rawValue
        case .ballWall:
            return Collisions.ball.rawValue | Collisions.wall.rawValue
        case .ballGround:
            return Collisions.ball.rawValue | Collisions.ground.rawValue
        }
    }
}
