//
//  GameViewController.swift
//  AppSprite
//
//  Created by ASENSI DOMINGO, FRAN on 05/11/2019.
//  Copyright © 2019 ASENSI DOMINGO, FRAN. All rights reserved.
//


import SpriteKit
import GameplayKit
import CoreData

class GameViewController: UIViewController {
var scene = GameScene()
  let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var menu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = GameScene(size: view.frame.size)
        let skView = view as! SKView

        skView.presentScene(scene)
        
    }
  
    @IBAction func OnClick(_ sender: Any) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MyEntity", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(scene.points_, forKey: "score")
        newUser.setValue(Date(), forKey: "day")
       do {
          try context.save()
         } catch {
          print("Failed saving")
       }
    }
}

    

