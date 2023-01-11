//
//  MenuViewController.swift
//  navigation + running
//
//  Created by 1 on 10.01.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBAction func oneTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
        
    }
    
}
