//
//  GameScene.swift
//  AppSprite
//
//  Created by ASENSI DOMINGO, FRAN on 05/11/2019.
//  Copyright © 2019 ASENSI DOMINGO, FRAN. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
var player_  = SKSpriteNode()
//var playerColor_ = UIColor.red
//var playerSize_ = CGSize(width: 50, height: 50)

class GameScene: SKScene {
    
    var motionManager = CMMotionManager()
    override func didMove(to view: SKView) {
     
        /*let recognizer = UITapGestureRecognizer(target: self, action:#selector(onetap))
        view.addGestureRecognizer(recognizer)*/
        spawnPlayer()
        addgestures()
        accelerometer()
        
        }
   /* override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLoc = touch.location(in: self)
            let angle = atan2(touchLoc.y-player_.position.y, touchLoc.x-player_.position.x)
            player_.zRotation = angle - CGFloat(Double.pi/2)
        }
    }*/
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
 
    func spawnPlayer(){
        //player_ = SKSpriteNode(color: playerColor_, size: playerSize_)
        let texture_ = SKTexture(imageNamed:"ship")
        texture_.filteringMode = SKTextureFilteringMode.nearest

               player_ = SKSpriteNode(texture: texture_)
        player_.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        print("aaaa")
        self.addChild(player_)
        
    }
    func addgestures(){
        let gestures_: [UISwipeGestureRecognizer.Direction] = [.up, .right, .down, .left]
        for gestures  in gestures_{
            let gesturesRec = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
            gesturesRec.direction = gestures
            self.view?.addGestureRecognizer(gesturesRec)
        }
    }
    @objc func swipe(gesture:UISwipeGestureRecognizer){
        if let gesture = gesture as? UISwipeGestureRecognizer{
           switch gesture.direction{
                      case .up:
                          
                        player_.zRotation = 2 * CGFloat.pi
                      case .down:
                           player_.zRotation = CGFloat.pi
                      case .right:
                        player_.zRotation =  3 * CGFloat.pi / 2
                      case .left:
                           player_.zRotation = CGFloat.pi/2
                      default:
                          break
            }
            
        }
    }
        func accelerometer(){
            
            if motionManager.isAccelerometerAvailable{
                motionManager.accelerometerUpdateInterval = 0.01
                motionManager.startAccelerometerUpdates(to: .main){
                    (data,error) in
                    guard let data = data, error == nil else{
                        return
                    }
                    if(data.acceleration.x > -0.04){
                        print("Reload")
                    }
                    print(data.acceleration.x)
                    
                }
            }
        }

}
