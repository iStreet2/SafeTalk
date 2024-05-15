//
//  ViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class NotasViewController: UIViewController {
    
    //Coisas do CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var notas: [Nota]?
    
    //Variáveis
    private var notasParaTeste:[String] = ["Hoje eu acordei pensando em voce","Pensando em coisas que eu nem sei por que","Ta duro desfarçar, me engana que eu ja sei", "Eu me pergunto se ai também", "Foi forteee.... sorte...."]
    
    private var datasParaTeste:[String] = ["11 de Março de 2024"]
    
    private var notasCollectionDataSource: NotasCollectionDataSource
    private var notasCollectionDelegate = NotasCollectionDelegate()
    
    
    //Componentes
    private let notasView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NotaCollectionViewCell.self, forCellWithReuseIdentifier: NotaCollectionViewCell.identifier)
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Hello, world!"
        titleLabel.font = UIFont(name: fonts.twinkle.rawValue, size: 40)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    init() {
        notasCollectionDataSource = NotasCollectionDataSource(notasParaTeste: notasParaTeste)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Ciclo de vida da NotasViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUpUI()
        
    }
    
    //Funções
    func setUpUI(){
        setNavigationTitle()
        setPlusButton()
        customizeBackButton()
        addNotas()
        
        
        self.notasView.dataSource = notasCollectionDataSource
        self.notasView.delegate = notasCollectionDelegate
        
        
        //Pegar itens do CoreData
        //        fetchNotas()
    }
    
    
    func setNavigationTitle(){
        self.title = "Notas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.twinkle.rawValue, size: 34)!]
        
        
        navigationController?.navigationBar.barTintColor = .background
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.tsukimiBold.rawValue, size: 17)!]
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
    }
    
    func setPlusButton(){
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
        
        
        self.view.addSubview(notasView)
        notasView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notasView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            notasView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            notasView.topAnchor.constraint(equalTo: self.view.topAnchor),
            notasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    @objc func navigate(){
        navigationController?.pushViewController(CriarNotaViewController(), animated: true)
    }
    
    @objc func navigateCollection(titulo: String, nota: String){
        let container = VisualizarNotaViewController()
        container.tituloLabel.text = titulo
        container.notaLabel.text = nota
        navigationController?.pushViewController(container, animated: true)
    }
    
    //Funções do CoreData
    //    func fetchNotas(){
    //        do{
    //            self.notas = try context.fetch(Nota.fetchRequest())
    //
    //        } catch{
    //            print("Não foi possivel pegar os items do CoreData, error: \(error)")
    //        }
    //    }
    
}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

