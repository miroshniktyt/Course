//
//  GameScene.swift
//  spriteKitTest
//
//  Created by 1 on 27.12.2022.
//

import SpriteKit
import GameplayKit


struct BitMasks {
    static let player: UInt32 = 1
    static let bonus: UInt32 = 2
    static let enemy: UInt32 = 4
}

class GameScene: SKScene {
    
    var score = 0 {
        didSet {
            label.text = "score : \(score)"
        }
    }
    
    let player = SKSpriteNode(texture: SKTexture(imageNamed: "player"), color: .blue, size: .init(width: 44, height: 44))
    
    let label = SKLabelNode()
    
    var isMovingRIght = true

    override func didMove(to view: SKView) {
        self.anchorPoint.x = 0.5
        
        score = 0
                
        player.position.y = self.frame.height / 4
        self.addChild(player)
        
        player.physicsBody = .init(rectangleOf: player.frame.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = false
//        player.physicsBody?.categoryBitMask = BitMasks.player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = BitMasks.bonus

        let sqns = SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run { self.putSomthing() },
        ])
        self.run(SKAction.repeatForever(sqns))
        
        addChild(label)
        label.position.y = 32
        
        physicsWorld.gravity = .init(dx: 0, dy: -5)
        physicsWorld.contactDelegate = self
    }
        
    override func update(_ currentTime: TimeInterval) {
        
        let playerSpeed: CGFloat = 4
        player.position.x += isMovingRIght ? playerSpeed : -playerSpeed

        if player.position.x > frame.maxX || player.position.x < frame.minX {
            isMovingRIght.toggle()
        }
        
    }
    
    func putSomthing() {
        
        let isStar = [true, true, true, false].randomElement()!
        
        putItem(isStar: isStar)
    }
    
    func putItem(isStar: Bool) {
        let bomb = SKShapeNode(circleOfRadius: 16)
        bomb.fillColor = isStar ? .yellow : .red
        bomb.position.y = frame.maxY
        bomb.position.x = .random(in: frame.minX...frame.maxX)
        
        bomb.physicsBody = .init(circleOfRadius: bomb.frame.width / 2)
        bomb.physicsBody?.categoryBitMask = isStar ? BitMasks.bonus : BitMasks.enemy
        bomb.physicsBody?.contactTestBitMask = BitMasks.player
//        bonus.physicsBody?.collisionBitMask = 0
        
        self.addChild(bomb)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMovingRIght.toggle()
    }
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("yes contact")
        
        if contact.bodyA.categoryBitMask == BitMasks.bonus {
            let body = contact.bodyA
            body.node?.removeFromParentWithParticles()
            score += 1
        } else if contact.bodyB.categoryBitMask == BitMasks.bonus {
            let body = contact.bodyB
            body.node?.removeFromParentWithParticles()
            score += 1
        }
        
        if contact.bodyA.categoryBitMask == BitMasks.enemy {
            fatalError()
        } else if contact.bodyB.categoryBitMask == BitMasks.enemy {
            fatalError()
        }
        
    }
}

extension SKNode {
    func removeFromParentWithParticles(particlesName: String = "maggic") {
        let part = SKEmitterNode(fileNamed: particlesName)!
        part.position = self.position
        self.position.addChild(part)
        self.removeFromParent()
    }
}
