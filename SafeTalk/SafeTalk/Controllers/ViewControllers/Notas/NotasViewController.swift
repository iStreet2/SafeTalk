//
//  ViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit
import LocalAuthentication

class NotasViewController: UIViewController {
    
    //MARK: Coisas para mandar pra AppStore, tirar depois
    var isAuthenticated: authenticationState = .authenticating
    
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    
    let blurEffectView: UIVisualEffectView = {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blur = UIVisualEffectView(effect: blurEffect)
        
        return blur
        
    }()
    
        
    //MARK: Coisas do CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notas: [Nota]?
    
    //MARK: Variáveis
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
        faceID()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Atualizar os dados do meu vetor de notas
        updateDataSourceAndDelegate()        
    }
    
    //MARK: Funçoes para mandar para a AppStore, colocar o faceID aqui, background, blur, coisas que estavam na TabBarViewController
    func faceID(){
        if isAuthenticated == .authenticating {
            initBackground()
            initBlur()
            
            authenticateTapped() { result in

                if result == true{
                    if self.isAuthenticated == .authenticated {
                        self.fetchNotas()
                        self.setElements()
                        self.removeBlur()
                    }
                }

            }
        }
    }
    
    func authenticateTapped(completion: @escaping (Bool) -> Void){
        let context = LAContext()
        var error: NSError?
    
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Se identifique por favor."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        //Se o usuário for autenticado:
                        self?.isAuthenticated = .authenticated
                        completion(true)
                    } else {
                        // error
                        self?.isAuthenticated = .unauthenticated
                        
                        let ac = UIAlertController(title: "Falha ao realizar autenticação", message: "Você não conseguir ser verificado; por favor tente novamente.", preferredStyle: .alert)
                        
                        let action = UIAlertAction(title: "Tentar Novamente", style: .default) { action in
                            self?.authenticateTapped() { success in
                                if success{
                                    self?.isAuthenticated = .authenticated
                                    completion(true)
                                }
                            }
                            
                        }
                        ac.addAction(action)
                        self?.present(ac, animated: true)
                        
                    }
                }
            }
        } else {
            // no biometry
            self.isAuthenticated = .authenticated
        }
        completion(false)
    }
    
    func initBackground(){
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "BackgroundShapes.png")?.draw(in: self.view.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }
        
        //Adiciono minha imagem ao fundo da tela e aplico os constraints
//        self.view.backgroundColor = .background
//        self.view.addSubview(image)
        
        //Aplicar as constraints
//        NSLayoutConstraint.activate([
//            image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            image.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            image.topAnchor.constraint(equalTo: self.view.topAnchor)
//            image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//        ])
//        //Mandar uma layer abaixo
//        image.layer.zPosition = -1
        
    }
    
    func initBlur(){
        blurEffectView.frame = view.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(blurEffectView)
    }
    
    func removeBlur(){
        blurEffectView.removeFromSuperview()
    }

    
    //MARK: Funções de componentes
    func setElements(){
        createDataSourceAndDelegate()
        setNavigationTitle()
        setPlusButton()
        setEraseAllDataButton()
        customizeBackButton()
        addNotas()
    }
    
    func createDataSourceAndDelegate(){
        // Preparar meu delagate e meu datasource
        notasCollectionDataSource = NotasCollectionDataSource(notas: notas)
        notasCollectionDelegate = NotasCollectionDelegate(navigationController: navigationController, notas: notas)
        
        self.notasView.dataSource = notasCollectionDataSource
        self.notasView.delegate = notasCollectionDelegate
    }
    
    func updateDataSourceAndDelegate(){
        self.fetchNotas()
        
        notasCollectionDelegate?.notas = notas
        notasCollectionDelegate?.navigationController = navigationController
        
        notasCollectionDataSource?.notas = notas
        
        notasView.reloadData()
    }
    
    
    func setNavigationTitle(){
        self.title = "Notas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.tsukimiBold.rawValue, size: 34)!]
        
        
        navigationController?.navigationBar.barTintColor = .background
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: fonts.tsukimiBold.rawValue, size: 17)!]
    }
    
    func setPlusButton(){
        //Aqui eu escolho a imagem, o estilo, e qual ação vai realizar
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(navigate))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setEraseAllDataButton(){
        //Aqui eu escolho a imagem, o estilo, e qual ação vai realizar
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteAllData))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
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
    
    //MARK: Funções de Lógica
    
    @objc func navigate(){
        navigationController?.pushViewController(CriarNotaViewController(), animated: true)
    }
    
    @objc func navigateCollection(titulo: String, nota: String){
        let container = VisualizarNotaViewController()
        container.tituloLabel.text = titulo
        container.textoLabel.text = nota
        navigationController?.pushViewController(container, animated: true)
    }

    //MARK: Funções do CoreData
    func fetchNotas(){
        
        self.notas?.removeAll()
        
        do{
            self.notas = try context.fetch(Nota.fetchRequest())
            
            DispatchQueue.main.async {
                self.notasView.reloadData()
            }
            
        } catch{
            print("Não foi possivel pegar os items do CoreData, error: \(error)")
        }
    }
    
    @objc func deleteAllData(){
        
        if self.notas == nil || self.notas?.count == 0 {
            let emptyAlert = UIAlertController(title: "Sem notas", message: "Não há notas para deletar!", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(emptyAlert, animated: true, completion: nil)
        }
        
        else{
            let alert = UIAlertController(title: "Deletar", message: "Quer mesmo deletar TODAS suas notas?", preferredStyle: .alert)
            
            guard let notas = notas else {return}
            
            
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
            let deleteData = UIAlertAction(title: "Deletar", style: .destructive) { action in
                
                for nota in notas {
                    self.context.delete(nota)
                }
                
                do {
                    try self.context.save()
                } catch{
                    print("Erro ao deletar o dado")
                }
                self.navigationController?.popViewController(animated: true)
                self.updateDataSourceAndDelegate()
            }
            
            alert.addAction(deleteData)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
    

    
}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

