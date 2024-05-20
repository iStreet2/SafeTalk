//
//  CriarNotaViewControllerDelegate.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 17/05/24.
//

import UIKit

class CriarNotaViewControllerTextViewDelegate: NSObject, UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.layer.opacity == 0.3 {
            textView.text = nil
            textView.layer.opacity = 1
        }
    }
}
