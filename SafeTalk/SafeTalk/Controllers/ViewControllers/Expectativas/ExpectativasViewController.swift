//
//  ExpectativasViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class ExpectativasViewController: UIViewController {
    
    //MARK: CoreDate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var expectativas: [Expectativa]?
    var jaEntrou: [JaEntrou]?
    
    //MARK: Variáveis
    var expectativaCollectionDataSource: ExpectativaCollectionDataSource?
    var expectativaCollectionDelegate: ExpectativaCollectionDelegate?
    
    
    //MARK: Componentes
    private let expectativasView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ExpectativaCollectionViewCell.self, forCellWithReuseIdentifier: ExpectativaCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adicionarExpectativasIniciais()
        createDataSourceAndDelegate()
        setElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDataSourceAndDelegate()
    }
    
    func setElements(){
        setNavigationTitle()
        setPlusButton()
        setDeleteAllDataButton()
        setExpectativas()
        customizeBackButton()
    }
    
    func setNavigationTitle(){
        self.title = "Expectativas"
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
    
    func setDeleteAllDataButton(){
        //Aqui eu escolho a imagem, o estilo, e qual ação vai realizar
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteAllData))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func setExpectativas(){
        self.view.addSubview(expectativasView)
        expectativasView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            expectativasView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            expectativasView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            expectativasView.topAnchor.constraint(equalTo: self.view.topAnchor),
            expectativasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    func customizeBackButton(){
        let backImage = UIImage(systemName: "chevron.left")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
        
    //MARK: Funções de lógica
    @objc func navigate(){
        navigationController?.pushViewController(CriarExpectativaViewController(), animated: true)
    }
    
    func createDataSourceAndDelegate(){
        // Preparar meu delagate e meu datasource
        self.fetchExpectativas()
        expectativaCollectionDataSource = ExpectativaCollectionDataSource(expectativas: expectativas)
        expectativaCollectionDelegate = ExpectativaCollectionDelegate(navigationController: navigationController, expectativas: expectativas)
        
        self.expectativasView.dataSource = expectativaCollectionDataSource
        self.expectativasView.delegate = expectativaCollectionDelegate
    
    }
    
    func updateDataSourceAndDelegate(){
        self.fetchExpectativas()
        
        expectativaCollectionDelegate?.expectativas = expectativas
        expectativaCollectionDelegate?.navigationController = navigationController
        
        expectativaCollectionDataSource?.expectativas = expectativas
        
        expectativasView.reloadData()
        
    }
    
    //MARK: Funções do CoreData
    
    func adicionarExpectativasIniciais(){
        let jaEntrou: [JaEntrou]
        
        do{
            jaEntrou = try context.fetch(JaEntrou.fetchRequest())
            
            //Se ele nunca entrou
            if jaEntrou.count == 0 {
                addExpectativa(titulo: "O que você espera de seu(sua) parceiro(a) quando diz que ama ele(a)?")
                addExpectativa(titulo: "O que você espera de seu(sua) parceiro(a) quando vocês saem para ir em um rolê com amigos?")
                addExpectativa(titulo: "O que você espera de seu(sua) parceiro(a) quando um de vocês está passando por dificuldade financeira?")
                addExpectativa(titulo: "O que você espera de seu(sua) parceiro(a) quando você diz que está triste?")
            }
            
            //Depois de adicionar, ja entrou eh criado
            addJaEntrou()
            
            
        } catch{
            print("Não foi possivel pegar os items do CoreData, error: \(error)")
        }
        
        
    }
    
    
    func fetchExpectativas(){
        
        self.expectativas?.removeAll()
        
        do{
            self.expectativas = try context.fetch(Expectativa.fetchRequest())
            
            DispatchQueue.main.async {
                self.expectativasView.reloadData()
            }
            
        } catch{
            print("Não foi possivel pegar os items do CoreData, error: \(error)")
        }
    }
    
    func addExpectativa(titulo: String){
        //Criar uma nota nova
        let expectativa = Expectativa(context: self.context)
        expectativa.titulo = titulo

        //Salvar no dispositivo
        do {
            try self.context.save()
        }
        catch {
            print("Error ao salvar nova expectativa")
        }
    }
    
    func addJaEntrou(){
        //Criar uma nota nova
        let jaEntrou = JaEntrou(context: self.context)
        jaEntrou.jaEntrou = true

        //Salvar no dispositivo
        do {
            try self.context.save()
        }
        catch {
            print("Error ao salvar ja entrou")
        }
    }
    
    @objc func deleteAllData(){
        
        if self.expectativas == nil || self.expectativas?.count == 0 {
            let emptyAlert = UIAlertController(title: "Sem expectativas", message: "Não há expectativas para deletar!", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(emptyAlert, animated: true, completion: nil)
        }
        
        else{
            let alert = UIAlertController(title: "Deletar", message: "Quer mesmo deletar TODAS suas expectativas?", preferredStyle: .alert)
            
            guard let expectativas = expectativas else {return}
            
            
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
            let deleteData = UIAlertAction(title: "Deletar", style: .destructive) { action in
                
                for nota in expectativas {
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
