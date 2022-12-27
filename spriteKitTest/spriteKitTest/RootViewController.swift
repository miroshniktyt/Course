//
//  RootViewController.swift
//  spriteKitTest
//
//  Created by 1 on 27.12.2022.
//

import UIKit
import SpriteKit

class RedScene: SKScene {
    
    let shape = SKShapeNode(circleOfRadius: 64)
    
    let myCamera = SKCameraNode()
    
    override func didMove(to view: SKView) {
        
        self.camera = myCamera
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        
        let node = SKNode() // container
        
        let texture = SKTexture(imageNamed: "crl") // спарайт який майже завжди юзаєтся
        let sprite = SKSpriteNode(texture: texture, color: .blue, size: .init(width: 90, height: 90))
        self.addChild(sprite)
        
        shape.position.y -= 200
        shape.fillColor = .blue
        self.addChild(shape)
        
        let label = SKLabelNode(text: "")
        
        self.backgroundColor = .red
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let spac: CGFloat = 50
        let sqns = SKAction.sequence([
            SKAction.move(by: .init(dx: spac, dy: spac), duration: 0.2),
            SKAction.move(by: .init(dx: spac, dy: -spac), duration: 0.2),
            SKAction.move(by: .init(dx: spac, dy: -spac), duration: 0.2),
            .scale(to: 0.5, duration: 0.2),
            .move(to: .zero, duration: 0.2),
        ])
        
        shape.run(SKAction.repeatForever(sqns))
        
        myCamera.run(.scaleX(to: 5, duration: 5))
    }
}

class RootViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = RedScene(size: .init(width: 2000, height: 2000))
        self.skView.presentScene(scene)
//        scene.scaleMode = .resizeFill
        
        self.view.backgroundColor = .black
    }
}
