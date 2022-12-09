//
//  AlertViewController.swift
//  week2wednesday
//
//  Created by 1 on 09.12.2022.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var massageLabel: UILabel!
    
    var alertData: AlertData?

    @IBAction func primTapped(_ sender: Any) {
        dismiss(animated: true)
        print(666)
    }
    
    @IBAction func secTapped(_ sender: Any) {
        dismiss(animated: true)
        print(999)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let alertData = alertData {
            titleLabel.text = alertData.title
            massageLabel.text = alertData.massage
        } else {
            print("oops")
        }
    }
    
}
