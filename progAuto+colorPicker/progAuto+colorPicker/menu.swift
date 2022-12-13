//
//  menu.swift
//  progAuto+colorPicker
//
//  Created by 1 on 13.12.2022.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func progTapped(_ sender: Any) {
        let vc = ProgramaticPickerViewController()
        vc.colors = [
            [.red, .yellow],
            [.green, .blue, .orange],
            [.clear, .white],
            [.blue, .black]
        ]
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    @IBAction func storyTapped(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "picker")
        if let pickerVC = vc as? PickerViewController {
            pickerVC.delegate = self
        }
        self.present(vc, animated: true)
    }
    
    
    
}

extension MenuViewController: ColorPickerDelegate {
    func didSelect(color: UIColor?) {
        view.backgroundColor = color
    }
    
    
}
