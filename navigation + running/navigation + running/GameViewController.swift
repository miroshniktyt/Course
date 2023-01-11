//
//  GameViewController.swift
//  navigation + running
//
//  Created by 1 on 04.01.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScene()
    }
    
    func setScene() {
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: .zero)
            scene.gameOverCallBack = { [weak self] in
                self?.gameOver()
            }
            scene.restartCallBack = { [weak self] in
                self?.setScene()
            }
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func gameOver() {
        let vc = UIAlertController(title: "GGAME OVER", message: "You fall too low", preferredStyle: .alert)
        
        let toMenuAction = UIAlertAction(title: "TO MENU", style: .default) {_ in
            self.dismiss(animated: true)
        }
        
        let restartAction = UIAlertAction(title: "RESTART", style: .default) {_ in
            self.setScene()
        }
        
        vc.addAction(toMenuAction)
        vc.addAction(restartAction)

        self.present(vc, animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
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
