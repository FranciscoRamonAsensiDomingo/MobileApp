//
//  GameViewController.swift
//  AppSprite
//
//  Created by ASENSI DOMINGO, FRAN on 05/11/2019.
//  Copyright © 2019 ASENSI DOMINGO, FRAN. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
        }
    }

    

