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
        backgroundColor = .darkGray
        
        self.anchorPoint.x = 0.5
        
        self.physicsWorld.gravity = .init(dx: 0, dy: 9)
        
        let sqr = SKShapeNode(rectOf: .init(width: 1000, height: 50))
        sqr.fillColor = .red
        self.addChild(sqr)
        print(self.frame)
        sqr.position.y = frame.maxY
        sqr.position.x = frame.midX
        sqr.physicsBody = .init(rectangleOf: sqr.frame.size)
        sqr.physicsBody?.isDynamic = false
        sqr.physicsBody?.friction = 1
        sqr.physicsBody?.restitution = 1
        
        let sqns = SKAction.sequence([
            .wait(forDuration: 1),
            .run {
                self.placeONRandom()
            }
        ])
        
        self.run(.repeatForever(sqns))
    }
    
    func placeONRandom() {
        let position = CGPoint(x: .random(in: -100...100), y: .random(in: -100...100))
        self.create(onPosition: position)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let position = touches.first!.location(in: self)
        create(onPosition: position)
    }
    
    func create(onPosition: CGPoint) {
        let r: CGFloat = 32
        let crcl = SKShapeNode(rectOf: .init(width: r, height: r))
        crcl.fillColor = .blue
        
        crcl.position = onPosition
        self.addChild(crcl)
        
        crcl.physicsBody = .init(circleOfRadius: r)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let position = touches.first!.location(in: self)
        if let node = self.nodes(at: position).first {
            node.physicsBody = nil
        }
        
    }
}

class RootViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    let scene = RedScene(size: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene.scaleMode = .resizeFill
        self.skView.presentScene(scene)
//        skView.showsPhysics = true
//        skView.showsFPS = true
        skView.showsNodeCount = true
        
        self.view.backgroundColor = .black
    }
    
    @IBAction func pouseed(_ sender: Any) {
        scene.isPaused.toggle()
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        let slider = (sender as! UISlider)
        scene.speed = CGFloat(slider.value)
    }
}
