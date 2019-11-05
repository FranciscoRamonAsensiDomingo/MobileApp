//
//  GameScene.swift
//  AppSprite
//
//  Created by ASENSI DOMINGO, FRAN on 05/11/2019.
//  Copyright © 2019 ASENSI DOMINGO, FRAN. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let label = SKLabelNode(text: "Hello")
    override func didMove(to view: SKView) {
        addChild(label)
        label.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        label.fontSize = 40
        label.fontColor = SKColor.white
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(onetap))
        view.addGestureRecognizer(recognizer)
        }
        
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    @objc func onetap(recognizer: UIGestureRecognizer){
        let viewlocation = recognizer.location(in: view)
        let scenelocation = convertPoint(fromView: viewlocation)
        let moveAction = SKAction.move(to: scenelocation, duration: 1)
        label.run(moveAction)
    }
}
