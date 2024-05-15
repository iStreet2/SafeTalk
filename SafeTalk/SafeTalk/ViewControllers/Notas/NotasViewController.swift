//
//  ViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class NotasViewController: UIViewController {
    
    //Coisas do CoreData
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var notas: [Nota]?
    
    //Variáveis
    //Mandar isso pro NotasViewCollectionViewDataSource
    //Vou ter uma variavel que eh um objeto dessa classe e vai receber esses dados aqui no meu viewDidLoad.
    private var notasParaTeste:[String] = ["Hoje eu acordei pensando em voce","Pensando em coisas que eu nem sei por que","Ta duro desfarçar, me engana que eu ja sei", "Eu me pergunto se ai também", "Foi forteee.... sorte...."]
    
    private var datasParaTeste:[String] = ["11 de Março de 2024"]
    
    
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
        
        
        self.notasView.dataSource = self
        self.notasView.delegate = self
        
        
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

//TODO: Trocar essas extensions por classes separadas de DataSource e Delegate, nao sei bem ainda como faz

extension NotasViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: Pegar a quantidade de notas do CoreData
        
        return self.notasParaTeste.count
    }
    
    //Aqui eu crio minhas celulas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotaCollectionViewCell.identifier, for: indexPath) as? NotaCollectionViewCell else {
            fatalError("Falhou em tentar pegar minha celula customizada na NotasViewController")
        }
        
        
        //TODO: Pegar notas e datas do CoreData
        let noteText = self.notasParaTeste[indexPath.row]
        let noteDate = self.datasParaTeste[0]
        
        cell.configure(noteText, noteDate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navigateCollection(titulo: collectionView.cellForItem(at: indexPath)., nota: collectionView.cellForItem(at: indexPath).getNota())
    }
    
    
}

extension NotasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 121)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }

}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

