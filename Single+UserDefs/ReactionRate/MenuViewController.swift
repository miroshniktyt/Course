//
//  ViewController.swift
//  ReactionRate
//
//  Created by Roman Yarmoliuk on 06.12.2022.
//

import UIKit

class MenuViewController: BaseViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicManager.shared.playWoow()
        
        let playButton = UIButton(
            type: .system,
            primaryAction: UIAction(title: "PLAY", handler: { _ in
                self.showGame()
            }))
        playButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(playButton)
        playButton.ancherToSuperviewsCenter()
    }
    
    func showGame() {
        let vc = GameVC()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
}
