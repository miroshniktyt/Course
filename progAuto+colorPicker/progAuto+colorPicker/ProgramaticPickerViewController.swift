//
//  ProgramaticPickerViewController.swift
//  progAuto+colorPicker
//
//  Created by 1 on 13.12.2022.
//

import UIKit

protocol ColorPickerDelegate: AnyObject {
    func didSelect(color: UIColor?)
}

class ProgramaticPickerViewController: UIViewController {
    
    var colors: [[UIColor]] = [
        [.red, .yellow],
        [.green, .blue, .orange]
    ]
    
    weak var delegate: ColorPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .yellow
        
        let bigStack = UIStackView()
        bigStack.spacing = 8
        bigStack.axis = .horizontal
        bigStack.distribution = .fillEqually
        
        
        for row in 0..<colors.count {
            
            let smallStack = UIStackView()
            smallStack.spacing = 8
            smallStack.axis = .vertical
            smallStack.distribution = .fillEqually
            
            let row = colors[row]
            
            for color in row {
                let btn = UIButton()
                btn.backgroundColor = color
                smallStack.addArrangedSubview(btn)
                btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
                
            }
            
            bigStack.addArrangedSubview(smallStack)
        }
        
        view.addSubview(bigStack)
        bigStack.translatesAutoresizingMaskIntoConstraints = false
        
        bigStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        bigStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bigStack.widthAnchor.constraint(equalToConstant: 256).isActive = true
        bigStack.heightAnchor.constraint(equalTo: bigStack.widthAnchor).isActive = true

    }
    
    @objc func btnTapped(_ sender: UIButton) {
        print(sender.backgroundColor)
        let color = sender.backgroundColor
        delegate?.didSelect(color: sender.backgroundColor)
        self.dismiss(animated: true)
    }


}
