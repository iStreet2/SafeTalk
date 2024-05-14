//
//  CriarNotaViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 14/05/24.
//

import UIKit

class CriarNotaViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Oi"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(titleLabel)
        // Do any additional setup after loading the view.
    }
    

}


@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}
