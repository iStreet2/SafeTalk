//
//  CriarNotaViewControllerDelegate.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 17/05/24.
//

import UIKit

class TextViewDelegate: NSObject, UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.layer.opacity == 0.3 {
            textView.text = nil
            textView.layer.opacity = 1
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.layer.opacity == 1 && textView.text == ""{
            textView.text = "O que você está pensando?"
            textView.layer.opacity = 0.3
        }
    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

