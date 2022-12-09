//
//  RootViewController.swift
//  week2wednesday
//
//  Created by 1 on 09.12.2022.
//

import UIKit

class RootViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let button = UIButton(type: .system)
        button.setTitle("tap", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let size = CGSize(width: 64, height: 64)
        let origin = CGPoint(x: view.frame.midX, y: view.frame.midY)
        button.frame = CGRect(origin: origin, size: size)
        self.view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        let genericViewController = "alert".getVC()
        let structura = AlertData(massage: "hi there", title: "friday mood")
        if let alertVC = (genericViewController as? AlertViewController) {
            alertVC.alertData = structura
        }
        self.present(genericViewController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.subviews.forEach { subview in
            
            subview.backgroundColor = .random
            
//            guard (subview is UILabel) else {
//                return
//            }
//            (subview as! UILabel).text = "yo"
            
//            if let label = subview as? UILabel {
//                label.text
//            } else {
//                print("not label")
//            }
            
            let opt = (subview as? UILabel)
            opt?.text = "texttttt"
                        
            if let rounded = subview as? Rounded {
                rounded.layer.borderColor = UIColor.yellow.cgColor
                rounded.layer.borderWidth = 4
                rounded.radius = 10
            }
        }
    }
    
}

extension UIColor {
    static var random: UIColor {
        UIColor(red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1)
    }
}
