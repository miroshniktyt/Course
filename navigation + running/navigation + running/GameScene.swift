//
//  GameScene.swift
//  navigation + running
//
//  Created by 1 on 04.01.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bet = Bet()
    
    let cam = SKCameraNode()
        
    override func didMove(to view: SKView) {
                
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.backgroundColor = .white
        
        self.camera = cam
        
        self.addChild(bet)
        
        let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        gestureRight.direction = .right
        view.addGestureRecognizer(gestureRight)
        
        let gestureUp = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        gestureUp.direction = .up
        view.addGestureRecognizer(gestureUp)
        
        let gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        gestureLeft.direction = .left
        view.addGestureRecognizer(gestureLeft)
        
        let floor = SKShapeNode(rectOf: .init(width: frame.width - 64, height: 32), cornerRadius: 16)
        floor.fillColor = .black
        self.addChild(floor)
        floor.position.y -= 150
        floor.physicsBody = .init(rectangleOf: floor.frame.size)
        floor.physicsBody?.isDynamic = false
        
        let floor2 = SKShapeNode(rectOf: .init(width: floor.frame.width, height: 32), cornerRadius: 16)
        floor2.fillColor = .black
        self.addChild(floor2)
        floor2.position.x += floor.frame.width
        floor2.physicsBody = .init(rectangleOf: floor2.frame.size)
        floor2.physicsBody?.isDynamic = false
    }
    
    @objc func swiped(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            bet.moveLeft()
        case .right:
            bet.moveRight()
        case .up:
            bet.jump()
        default:
            bet.stay()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = bet.position
    }
    
    
    
}
