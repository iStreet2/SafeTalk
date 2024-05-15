//
//  CriarNotaViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 14/05/24.
//

import UIKit
import CoreData

class CriarNotaViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Hello world!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Referencia para o objeto contexto
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Minhas notas vão ser um vetor de notas, definido no Model do CoreData
    var nota: Nota?

    override func viewDidLoad() {
        super.viewDidLoad()
        setHelloWorld()
        
//        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    
    func setHelloWorld(){
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    

}


@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}
