//
//  ViewController.swift
//  week2wednesday
//
//  Created by 1 on 07.12.2022.
//

import UIKit

class SqrsViewController: UIViewController {
    
    var arrOrSqrt: [UIView] = []
    
    var count = 0
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
//        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(placeRandomView), userInfo: nil, repeats: true)
        
        // !!! DRY
                
        date = Date()
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            self.placeRandomView()

            self.count += 1
            if self.count > 15 {
                timer.invalidate()
                self.endGame()
            }
        }
    }
        
    func endGame() {
        self.arrOrSqrt.forEach { sqrt in
//            UIView.animate(withDuration: 0.5) {
//                sqrt.frame.size = .init(width: 8, height: 8)
//            }
        }
        
        let newDate = Date() // почитайте про це
        
        let timeInterval = newDate.timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate
        
        let vc = UIAlertController(title: "Title", message: "game took \(timeInterval) seconds", preferredStyle: .alert)
        vc.overrideUserInterfaceStyle = .dark
        
        let action = UIAlertAction(title: "play again", style: .default) {_ in
            self.playAgain()
        }
        vc.addAction(action)
        
        let exitAction = UIAlertAction(title: "exit", style: .destructive) {_ in
            fatalError()
        }
        vc.addAction(exitAction)
                
        present(vc, animated: true)
    }
    
    func playAgain() {
        count = 0
        // !!! DRY
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            self.placeRandomView()

            self.count += 1
            if self.count > 15 {
                timer.invalidate()
                self.endGame()
            }
        }
        
        // maybe remove subviews
    }
    
    func placeRandomView() {
        let randomView = UIView()
        randomView.backgroundColor = getRandonColor()
        randomView.frame.size = UIConsts.buttonSize
        let newRandonPosition = CGPoint(
            x: .random(in: view.frame.minX...view.frame.maxX),
            y: .random(in: view.frame.minY...view.frame.maxY)
        )
        randomView.center = newRandonPosition
        
        while isRectIntersectsWithAnySqrtOnScreen(rect: randomView.frame) {
            let newRandonPosition = CGPoint(
                x: .random(in: view.frame.minX...view.frame.maxX),
                y: .random(in: view.frame.minY...view.frame.maxY)
            )
            randomView.center = newRandonPosition
            print("oops hane to replace randomView")
        }
        
        self.view.addSubview(randomView)
        self.arrOrSqrt.append(randomView)
    }
    
    func isRectIntersectsWithAnySqrtOnScreen(rect: CGRect) -> Bool {
        var isIntersects = false
        arrOrSqrt.forEach { oldSqrt in
            if oldSqrt.frame.intersects(rect) {
                isIntersects = true
                print(666)
                return
            }
        }
        return isIntersects
    }
    
    func getRandonColor() -> UIColor {
        UIColor(red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1)
    }

}

struct Person {
    let name: String
}

class Rounded: UIView {
    
    var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = 32
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.layer.cornerRadius = 32
    }
}
