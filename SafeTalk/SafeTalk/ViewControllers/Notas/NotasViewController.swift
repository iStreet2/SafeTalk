//
//  ViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit
import SwiftUI

class NotasViewController: UIViewController {
    
    //Variáveis
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Hello, world!"
        titleLabel.font = UIFont(name: fonts.twinkle.rawValue, size: 40)
        titleLabel.textColor = .white
        //Permite fazer constraints via codigo, se for true, ele espera um StoryBoard
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    


    
    //Ciclo de vida da NotasViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setRightNavigationItem()
        customizeBackButton()

    }
    
    //Funções
    
    func setNavigationTitle(){
        self.title = "Notas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.twinkle.rawValue, size: 34)!]
    }
    
    func setRightNavigationItem(){
        //Aqui eu escolho a imagem, o estilo, e qual ação vai realizar
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(navigate))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func customizeBackButton(){
        let backImage = UIImage(systemName: "chevron.left")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    @objc func navigate(){
        navigationController?.pushViewController(CriarNotaViewController(), animated: true)
    }


}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

