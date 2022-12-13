//
//  ViewController.swift
//  progAuto+colorPicker
//
//  Created by 1 on 13.12.2022.
//

import UIKit


class PickerViewController: UIViewController {
    
    weak var delegate: ColorPickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    var selectedView: UIView = UIView()
        
    @IBAction func colorTapped(_ sender: Any) {
        if let sender = sender as? UIView {
            selectedView.layer.borderWidth = 0
            selectedView = sender
            selectedColor = sender.backgroundColor
            sender.layer.borderWidth = 8
            sender.layer.borderColor = view.backgroundColor?.cgColor
        }
    }
    
    var selectedColor: UIColor?
    
    @IBAction func selected(_ sender: Any) {
        if let color = selectedColor {
            delegate?.didSelect(color: color)
        }
        self.dismiss(animated: true)
    }
    
    
    
}

