//
//  Extensions.swift
//  Ggwow
//
//  Created by user1 on 08.06.2022.
//

import SpriteKit

extension CGVector {
    static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
        CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }
}

