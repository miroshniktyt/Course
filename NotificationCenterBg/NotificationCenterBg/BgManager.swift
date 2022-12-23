//
//  BgManager.swift
//  asd
//
//  Created by 1 on 23.12.2022.
//

import Foundation

extension NSNotification.Name {
    static let changeName = NSNotification.Name("changeBg")
}

class ImageBgManager {
    
    static let shared = ImageBgManager()
        
    private let key = "backgroundImage"
    let defaultBg = "bg1"
    
    var currentBg: String {
        get {
            UserDefaults.standard.string(forKey: key) ?? defaultBg
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    func changeBg(to bgName: String) {
        currentBg = bgName
        
        NotificationCenter.default.post(
            name: .changeName,
            object: bgName)
    }
}
