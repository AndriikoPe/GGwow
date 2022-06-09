//
//  LoseGameScene.swift
//  Ggwow
//
//  Created by user1 on 09.06.2022.
//

import SpriteKit

class LoseGameScene: SKScene {
    override func didMove(to view: SKView) {
        let label = SKLabelNode(fontNamed: "Helvetica Bold")
        label.text = "You suck!"
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(label)
        
        playAgain()
    }
    
    private func playAgain() {
        run(.wait(forDuration: 3)) { [weak self] in
            guard let self = self,
                  let gameScene = GameScene(fileNamed: "GameScene")
            else { return }
            self.view?.presentScene(
                gameScene,
                transition: .doorway(withDuration: 1)
            )
        }
    }
}
