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



class GameScene: SKScene , SKPhysicsContactDelegate {
    var numproj_ = 4
    var points_ = 0
    var enemycount_ = 0
    var updateTime_:Double  = 0
    var player_  = SKSpriteNode()
    var enemy_ = SKSpriteNode()
    var motionManager = CMMotionManager()
    var labelprojectile_ = SKLabelNode(fontNamed: "Chalkduster")
    var labelPoints_ = SKLabelNode(fontNamed: "Chalkduster")
    
    let fire_ = SKSpriteNode(imageNamed: "fire")
    var alive_ = true
    let playerCategory_:UInt32 = 0x1 << 0
    let bulletCategory_:UInt32 = 0x1 << 1
    let enemyCategory_:UInt32  = 0x1 << 2
    var time :Double  = 0
    override func didMove(to view: SKView) {
     
        self.physicsWorld.contactDelegate = self
        spawnPlayer()
       
        addgestures()
        accelerometer()
        labelprojectile_.text = String(self.numproj_)
        labelprojectile_.fontSize = 45
        labelprojectile_.fontColor = SKColor.white
        labelprojectile_.position = CGPoint(x: frame.minX + 80 , y:frame.maxY-50)
        addChild(labelprojectile_)
        labelPoints_.text = String(self.points_)
        labelPoints_.fontSize = 45
        labelPoints_.fontColor = SKColor.white
        labelPoints_.position = CGPoint(x: frame.maxX - 100 , y:frame.maxY-50)
        addChild(labelPoints_)
        fire_.position = CGPoint(x: frame.minX + 30 , y:frame.maxY-30)
        addChild(fire_)
        }
  
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(alive_ == false) {
           enemy_.removeFromParent()
           fire_.removeFromParent()
            
           labelprojectile_.text = String("YOU DIE")
           labelprojectile_.fontSize = 60
           labelprojectile_.fontColor = SKColor.white
           labelprojectile_.position = CGPoint(x: frame.midX  , y:frame.midY)
        
           
            
        }
        if updateTime_ == 0 {
            updateTime_ = currentTime
        }

        if currentTime - updateTime_ > 1 {
            self.spawnEnemys(duration_: 4 - time)
            time+=0.25
            if(time>=3.5){
                time = 3.5;
            }
            updateTime_ = currentTime
        }
        
       
    }
 
    func spawnPlayer(){
        //player_ = SKSpriteNode(color: playerColor_, size: playerSize_)
        let texture_ = SKTexture(imageNamed:"dragon")
        texture_.filteringMode = SKTextureFilteringMode.nearest

               player_ = SKSpriteNode(texture: texture_)
        player_.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        player_.physicsBody = SKPhysicsBody(rectangleOf: player_.size)
        player_.physicsBody?.affectedByGravity = false
        player_.physicsBody?.isDynamic = true
        player_.physicsBody?.categoryBitMask = playerCategory_
        player_.physicsBody?.collisionBitMask = enemyCategory_
        player_.physicsBody?.contactTestBitMask = enemyCategory_
        self.addChild(player_)

    }
    func spawnEnemys(duration_:Double){
            
           //player_ = SKSpriteNode(color: playerColor_, size: playerSize_)
       
            
        
        let texture_ = SKTexture(imageNamed:"eyelander")
           texture_.filteringMode = SKTextureFilteringMode.nearest

           enemy_ = SKSpriteNode(texture: texture_)
        let randomXStart = Int.random(in: 0 ... 3)

        switch randomXStart{
        case 0 :
              enemy_.position  = CGPoint(x: self.frame.midX, y: self.frame.maxY)
        case 1 :
             enemy_.position  = CGPoint(x: self.frame.midX, y: self.frame.minY)
        case 2 :
             enemy_.position  =  CGPoint(x: self.frame.maxX, y: self.frame.midY)
        case 3 :
             enemy_.position  =  CGPoint(x: self.frame.minX, y: self.frame.midY)
        default : break
        }
           
           let action = SKAction.move(to: CGPoint(
                     x: player_.position.x,
                     y: player_.position.y
           ),duration: duration_)
        let actionDone = SKAction.removeFromParent()
        enemy_.run(SKAction.sequence([action, actionDone]))

        enemy_.physicsBody = SKPhysicsBody(rectangleOf: enemy_.size)
        enemy_.physicsBody?.affectedByGravity = false
        enemy_.physicsBody?.isDynamic = true
        enemy_.physicsBody?.categoryBitMask = enemyCategory_
        enemy_.physicsBody?.collisionBitMask = bulletCategory_
        self.addChild(enemy_)
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
//        if let gesture = gesture as? UISwipeGestureRecognizer{
           switch gesture.direction{
                      case .up:
                        player_.zRotation =  3 * CGFloat.pi / 2
                        shoot(rot: CGFloat.pi)
                      case .down:
                        player_.zRotation = CGFloat.pi/2
                        shoot(rot: 2 * CGFloat.pi)
                      case .right:
                        player_.zRotation =   CGFloat.pi
                        shoot(rot:  CGFloat.pi/2)
                      case .left:
                        player_.zRotation = 2 * CGFloat.pi
                        shoot(rot: 3 * CGFloat.pi / 2)
                      default:
                          break
            }
           
//        }
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
                        self.numproj_ = 4
                        self.labelprojectile_.text = String(self.numproj_)
                    }
                   
                    
                }
            }
        }
    func shoot( rot: CGFloat) {
        if(numproj_ > 0 && self.alive_ == true){
            self.numproj_ -= 1
            labelprojectile_.text = String(self.numproj_)
    let projectile_ = SKSpriteNode(imageNamed: "fire")
    projectile_.zPosition = -5

    projectile_.position = player_.position
    projectile_.zRotation = rot
    projectile_.zPosition = player_.zPosition

        let action = SKAction.move(to: CGPoint(
            x: -700 * cos(player_.zRotation) + projectile_.position.x,
            y: -700 * sin(player_.zRotation) + projectile_.position.y
        ),duration: 0.8)
    
    let actionDone = SKAction.removeFromParent()
        projectile_.run(SKAction.sequence([action, actionDone]))

        projectile_.physicsBody = SKPhysicsBody(rectangleOf: projectile_.size)
        projectile_.physicsBody?.affectedByGravity = false
        projectile_.physicsBody?.isDynamic = true
        projectile_.physicsBody?.categoryBitMask = bulletCategory_
        projectile_.physicsBody?.collisionBitMask = enemyCategory_
        projectile_.physicsBody?.contactTestBitMask = enemyCategory_
        self.addChild(projectile_)
         
       
        
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == enemyCategory_ | bulletCategory_{
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            points_+=100
            labelPoints_.text = String(self.points_)
        }
      if collision == enemyCategory_ | playerCategory_{
               contact.bodyA.node?.removeFromParent()
               contact.bodyB.node?.removeFromParent()
               alive_ = false
           }
    }
  
}

