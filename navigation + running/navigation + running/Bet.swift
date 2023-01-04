//
//  Bet.swift
//  navigation + running
//
//  Created by 1 on 04.01.2023.
//

import SpriteKit

class Bet: SKSpriteNode {
    
    enum State {
        case left, right, stay
        
        var texturesBaseName: String {
            switch self {
            case .left:
                return "left"
            case .right:
                return "right"
            case .stay:
                return "dawn"
            }
        }
        
        var textures: [SKTexture] {
            let name = self.texturesBaseName
            var arr = [SKTexture]()
            for i in 0...5 {
                let text = SKTexture(imageNamed: "\(name)\(i)")
                arr.append(text)
            }
            return arr
        }
    }
    
    private let movementKey = "movement"
    private let movementSpeed: CGFloat = 70
    
    init() {
        let texture = SKTexture(imageNamed: "dawn0")
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.physicsBody = .init(circleOfRadius: self.size.width / 2)
        self.physicsBody?.mass = 1
        
        self.stay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveLeft() {
        self.animateTextures(forState: .left)
        
        self.removeAction(forKey: movementKey)
        self.run(.repeatForever(.moveBy(x: -movementSpeed, y: 0, duration: 1)), withKey: movementKey)
    }
    
    func moveRight() {
        self.animateTextures(forState: .right)

        self.removeAction(forKey: movementKey)
        self.run(.repeatForever(.moveBy(x: movementSpeed, y: 0, duration: 1)), withKey: movementKey)
    }
    
    func stay() {
        self.animateTextures(forState: .stay)
        
        self.removeAction(forKey: movementKey)
    }
    
    private func animateTextures(forState state: State) {
        let animateAction = SKAction.animate(
            with: state.textures,
            timePerFrame: 0.1,
            resize: true,
            restore: false)
        
        self.run(.repeatForever(animateAction))
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(.init(dx: 0, dy: 600))
    }

}
