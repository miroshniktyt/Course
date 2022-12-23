//
//  ChangeViewController.swift
//  asd
//
//  Created by 1 on 23.12.2022.
//

import UIKit

class ChangeViewController: ImageBgViewController {
    
    @IBAction func change(_ sender: Any) {
        ImageBgManager.shared.changeBg(to: "bg1")
    }
    
    @IBAction func change2(_ sender: Any) {
        ImageBgManager.shared.changeBg(to: "bg2")
    }
    
}
