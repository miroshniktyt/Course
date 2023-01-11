//
//  GameScene.swift
//  navigation + running
//
//  Created by 1 on 04.01.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var isPlaying = true
    
    var gameOverCallBack: (() -> ())?
    
    var restartCallBack: (() -> ())?
    
    var bet = Bet()
    
    let cam = SKCameraNode()
        
    override func didMove(to view: SKView) {
        
        isUserInteractionEnabled
                
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.backgroundColor = .white
        
        self.camera = cam
        self.addChild(cam)
        
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
        
        guard isPlaying else { return }
        
        if bet.position.y < -500 {
            isPlaying = false
            print("tell vc that game is pver")
            showGameOver()
//            gameOverCallBack?()
        }
    }
        
    func showGameOver() {
        let overNode = OverNode(size: self.frame.size) {
            self.restartCallBack?()
        }
        overNode.name = "over"
        cam.addChild(overNode)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TAP")
    }
    
}


class OverNode: SKNode {
    
    let tappedCallBack: () -> ()
    
    init(size: CGSize, tappedCallBack: @escaping () -> ()) {
        self.tappedCallBack = tappedCallBack
        
        super.init()
        
        self.zPosition = 100
        self.isUserInteractionEnabled = true
        
        print(self.frame.size)
        let overLayer = SKShapeNode(rectOf: size)
        overLayer.fillColor = .black.withAlphaComponent(0.8)
        overLayer.lineWidth = 0
        
        let gameOverLabel = SKLabelNode(text: "GAME OVER")
        
        let tapLabel = SKLabelNode(text: "TAP ANYWHERE TO RESTART")
        tapLabel.fontSize = 12
        tapLabel.position.y -= size.height / 2 - 64 - tapLabel.frame.height
        let action = SKAction.sequence([
            .scale(to: 1.2, duration: 1),
            .scale(to: 1.0, duration: 1),
        ])
        tapLabel.run(.repeatForever(action))
        
        [overLayer, gameOverLabel, tapLabel].forEach {
            self.addChild($0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tappedCallBack()
    }
}
