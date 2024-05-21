//
//  CriarNotaViewTituloDelegate.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 20/05/24.
//

import UIKit

class CriarNotaViewTituloDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.layer.opacity == 0.3 {
            textField.layer.opacity = 1
            textField.placeholder = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            textField.layer.opacity = 0.3
            textField.placeholder = "Título"
        }
    }
    
}
