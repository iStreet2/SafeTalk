//
//  GravacoesViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class GravacoesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    
    func setElements(){
        setNavigationTitle()
        setPlusButton()
        setDeleteAllDataButton()
        customizeBackButton()
    }
    
    func setNavigationTitle(){
        self.title = "Gravações"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.tsukimiBold.rawValue, size: 34)!]
        
        
        navigationController?.navigationBar.barTintColor = .background
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.tsukimiBold.rawValue, size: 17)!]
    }
    
    func customizeBackButton(){
        let backImage = UIImage(systemName: "chevron.left")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setPlusButton(){
        //Aqui eu escolho a imagem, o estilo, e qual ação vai realizar
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(navigate))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setDeleteAllDataButton(){
        //Aqui eu escolho a imagem, o estilo, e qual ação vai realizar
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteAllData))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func navigate(){
        navigationController?.pushViewController(GravarAudioViewController(), animated: true)
    }
    @objc func deleteAllData(){
        
    }
    
}

@available(iOS 17, *)
#Preview{
    
    TabBarController()
    
}
