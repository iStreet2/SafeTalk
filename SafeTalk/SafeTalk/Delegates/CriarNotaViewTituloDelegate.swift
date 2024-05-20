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
}
