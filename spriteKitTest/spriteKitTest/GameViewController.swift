//
//  GameViewController.swift
//  spriteKitTest
//
//  Created by 1 on 27.12.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = (self.view as! SKView)
        
        let scene = GameScene(size: .zero)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        skView.showsPhysics = true
//        skView.showsFPS = true
        skView.showsNodeCount = true
        
        self.view.backgroundColor = .black
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
