//
//  BlackVC.swift
//  ReactionRate
//
//  Created by Roman Yarmoliuk on 11.12.2022.
//

import UIKit

class GameVC: BaseViewController {
        
    let yellowViewSize = 50.0
    
    var yellowView: UIView = {
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        yellowView.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        yellowView.layer.cornerRadius = 25
        return yellowView
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.textColor = .white
        countLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        countLabel.text  = "Count: \(circlesCount)"
        countLabel.textAlignment = .center
        return countLabel
    }()
    
    var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textColor = .white
        timerLabel.widthAnchor.constraint(equalToConstant: 62).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        timerLabel.textAlignment = .center
        return timerLabel
    }()
    
    var circlesCount = 0
    var timer = Timer()
    let goal = 3
    var gameStartedTime = TimeInterval()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        createBackButton()
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 0
        
        stackView.addArrangedSubview(timerLabel)
        stackView.addArrangedSubview(countLabel)
        
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        
        
        view.addSubview(yellowView)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        gameStartedTime = Date().timeIntervalSinceReferenceDate
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        MusicManager.shared.playTock()
        
        let touch = touches.first!.location(in: self.view)
        
        if yellowView.frame.contains(touch) {
            
            circlesCount += 1
            moveYellowView()
            
            if circlesCount == goal {
                showResult()
            }
        }
        
        countLabel.text = "Count: \(circlesCount)"
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        moveYellowView()
    }
    
    func showResult() {
        let gameEndedTime = Date().timeIntervalSinceReferenceDate
        let time = gameEndedTime - gameStartedTime
        let result = "\(String(format: "%.1f",(time))) seconds \n"
        
        let bestResultKey = "newBestResult"
        let bestTime = UserDefaults.standard.double(forKey: bestResultKey)
        let isGetNewBest = (bestTime == 0) || (bestTime > time)
        
        if isGetNewBest {
            MusicManager.shared.playWin()
            UserDefaults.standard.setValue(time, forKey: bestResultKey)
        } else {
            MusicManager.shared.playOver()
        }
        
        let message = "score - \(result)\nbest score - \(bestTime)"
        let title = isGetNewBest ? "NEW BEST SCORE" : "GAME OVER"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "replay", style: .default) { _ in
            self.resetGame()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func resetGame() {
        MusicManager.shared.playStart()
        
        moveYellowView()
        gameStartedTime = Date().timeIntervalSinceReferenceDate
        circlesCount = 0
        countLabel.text = "Count: \(self.circlesCount)"
    }
    
    func createBackButton() {
        let button = UIButton(frame: CGRect(x: 10, y: 50, width: 60, height: 35))
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func backButtonAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
        
        MusicManager.shared.playVggooh()
        timer.invalidate()
    }
    
    func moveYellowView() {
        MusicManager.shared.playTick()
        
        let minX = view.safeAreaLayoutGuide.layoutFrame.minX
        let minY = view.safeAreaLayoutGuide.layoutFrame.minY

        let maxX = view.safeAreaLayoutGuide.layoutFrame.maxX - yellowViewSize
        let maxY = view.safeAreaLayoutGuide.layoutFrame.maxY - yellowViewSize

        let randomX = CGFloat.random(in: minX...maxX)
        let randomY = CGFloat.random(in: minY...maxY)

        yellowView.frame.origin.x = randomX
        yellowView.frame.origin.y = randomY
    }
    
    @objc func updateTimer() {
        let nowTime = Date().timeIntervalSinceReferenceDate
        let time = nowTime - gameStartedTime
        var result = "\(String(format: "%.1f",(time)))"
        timerLabel.text = result
    }


    deinit {
        print("game deinited")
    }
}
