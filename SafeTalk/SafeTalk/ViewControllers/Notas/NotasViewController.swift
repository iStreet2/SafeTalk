//
//  ViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class NotasViewController: UIViewController {
    
    //Variáveis
    
    //Componentes
    private let notasView: UICollectionView = {
        let layout = UICollectionViewLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Hello, world!"
        titleLabel.font = UIFont(name: fonts.twinkle.rawValue, size: 40)
        titleLabel.textColor = .white
        //Permite fazer constraints via codigo, se for true, ele espera um StoryBoard
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    //Coisas do CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notas: [Nota]?
    
    //Ciclo de vida da NotasViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //Funções
    func setUpUI(){
        setNavigationTitle()
        setRightNavigationItem()
        customizeBackButton()
        addNotas()
        
        //Pegar itens do CoreData
//        fetchNotas()
    }
    
    
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
    
    func addNotas(){
        for _ in 0...3 {
            
        }
        
        self.view.addSubview(notasView)
        notasView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notasView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            notasView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            notasView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 20),
            notasView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])

    }
    
    @objc func navigate(){
        navigationController?.pushViewController(CriarNotaViewController(), animated: true)
    }
    
    //Funções do CoreData
    func fetchNotas(){
        do{
            self.notas = try context.fetch(Nota.fetchRequest())

        } catch{
            print("Não foi possivel pegar os items do CoreData, error: \(error)")
        }
    }

}



@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

