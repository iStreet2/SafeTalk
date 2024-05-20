//
//  ViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class NotasViewController: UIViewController {
        
    //MARK: Coisas do CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notas: [Nota]?
    
    //MARK: Variáveis
    private var notasParaTeste:[String] = ["Hoje eu acordei pensando em voce","Pensando em coisas que eu nem sei por que","Ta duro desfarçar, me engana que eu ja sei", "Eu me pergunto se ai também", "Foi forteee.... sorte...."]
    
    private var datasParaTeste:[String] = ["11 de Março de 2024"]
    
    private var notasCollectionDataSource: NotasCollectionDataSource?
    private var notasCollectionDelegate: NotasCollectionDelegate?
    
    
    //MARK: Componentes
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
    
    //MARK: Ciclo de vida da NotasViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Atualizar os dados do meu vetor de notas
        self.fetchNotas()
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Atualizar os dados do meu vetor de notas
        self.fetchNotas()
        updateDataSourceAndDelegate()        
        print("chamandoooo")
    }
    
    //MARK: Funções de componentes
    func setUpUI(){
        createDataSourceAndDelegate()
        setNavigationTitle()
        setPlusButton()
        customizeBackButton()
        addNotas()
        
        self.notasView.dataSource = notasCollectionDataSource
        self.notasView.delegate = notasCollectionDelegate
    }
    
    func createDataSourceAndDelegate(){
        // Preparar meu delagate e meu datasource
        notasCollectionDataSource = NotasCollectionDataSource(notas: notas)
        notasCollectionDelegate = NotasCollectionDelegate(navigationController: navigationController, notas: notas)
    }
    
    func updateDataSourceAndDelegate(){
        notasCollectionDelegate?.notas = notas
        notasCollectionDelegate?.navigationController = navigationController
        
        notasCollectionDataSource?.notas = notas
        notasView.reloadData()
        
    }
    
    
    func setNavigationTitle(){
        self.title = "Notas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.twinkle.rawValue, size: 34)!]
        
        
        navigationController?.navigationBar.barTintColor = .background
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.tsukimiBold.rawValue, size: 17)!]
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
    
    //MARK: Funções do CoreData
    func fetchNotas(){
        do{
            self.notas = try context.fetch(Nota.fetchRequest())
            
            DispatchQueue.main.async {
                self.notasView.reloadData()
            }
            
        } catch{
            print("Não foi possivel pegar os items do CoreData, error: \(error)")
        }
    }
    
    func addNota(titulo: String, texto: String){
        
        //Criar uma nota nova
        let nota = Nota(context: self.context)
        nota.titulo = titulo
        nota.texto = texto
        
        //Salvar no dispositivo
        do {
            try self.context.save()
        }
        catch {
            print("Error ao salvar nova nota")
        }
        
        
    }
    
    func reset(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! UICollectionViewCell
        let i = self.notasView.indexPath(for: cell)!.item
        notas?.remove(at: i) //replace favoritesInstance.favoritesArray with your own array
        self.notasView.reloadData() // replace favoritesCV with your own collection view.
    }
    
}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

