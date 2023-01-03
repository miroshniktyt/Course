//
//  GameScene.swift
//  SKActionsDemo
//
//  Created by 1 on 02.01.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func update(_ currentTime: TimeInterval) {
        print(currentTime)
    }
    
    let rounded = SKShapeNode(rectOf: .init(width: 48, height: 48), cornerRadius: 12)
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        
        let squre = SKSpriteNode(texture: nil, color: .yellow, size: .init(width: 48, height: 48))
        self.addChild(squre)
        
        let texture = SKTexture(imageNamed: "player")
        let player = SKSpriteNode(texture: texture, color: .clear, size: .init(width: 48, height: 48))
        player.position.y = frame.maxY - player.frame.height - 64
        self.addChild(player)
        
        let rounded = SKShapeNode(rectOf: .init(width: 48, height: 48), cornerRadius: 12)
        rounded.fillColor = .yellow
        rounded.position.y = frame.minY + rounded.frame.height + 64
        self.addChild(rounded)
        
        // delay
        self.run(.wait(forDuration: 2)) {
            self.startChangingBG()
        }
    }
    
    func startChangingBG() {
        let sqns = SKAction.sequence([
            .wait(forDuration: 0.5),
            .run { self.changeBG() }
        ])
        self.run(.repeatForever(sqns), withKey: "changeBgKey")
    }
    
    func changeBG() {
        self.backgroundColor = . init(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
//        node.removeFromParent()
        
        if node == self {
//            self.removeAllActions()
//            self.children.forEach {
//                $0.removeAllActions()
//            }
            let action = self.action(forKey: "changeBgKey")
            action?.speed *= 2
        }
        
        node.run(moveToAllCorners)
    }
    
    var groupMoveAction: SKAction {
        let moveUpRight = SKAction.moveBy(x: 100, y: 100, duration: 2)
        let rotate = SKAction.rotate(toAngle: .pi, duration: 2)
        let scaleUp = SKAction.scale(to: 2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 0.5, duration: 0.2)
        let scaleToNormal = SKAction.scale(to: 1, duration: 0.5)
        let scaleSqns = SKAction.sequence([scaleDown, scaleUp, scaleDown, scaleToNormal])
        let allTogether = SKAction.group([scaleSqns, moveUpRight, rotate])
        return allTogether
    }
    
    var moveToAllCorners: SKAction {
        let moveTopRight = SKAction.move(to: .init(x: frame.maxX, y: frame.maxY), duration: 0.5)
        let moveButtonRight = SKAction.move(to: .init(x: frame.maxX, y: frame.minY), duration: 0.5)
        let moveButtonLeft = SKAction.move(to: .init(x: frame.minX, y: frame.minY), duration: 0.5)
        let moveTopLeft = SKAction.move(to: .init(x: frame.minX, y: frame.maxY), duration: 0.5)
        let allTogether = SKAction.sequence([moveTopRight, moveButtonRight, moveButtonLeft, moveTopLeft])
        
        // not forever
        return SKAction.repeat(allTogether, count: 3)
    }


}
