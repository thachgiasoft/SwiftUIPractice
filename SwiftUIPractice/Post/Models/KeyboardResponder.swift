//
//  KeyboardResponder.swift
//  SwiftUIPractice
//
//  Created by lizhu on 2020/4/20.
//  Copyright © 2020 lizhu. All rights reserved.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published
    var keyboardHeight: CGFloat = 0
    
    var keyboardShow: Bool { keyboardHeight > 0 }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification){
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        keyboardHeight = frame.height
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
