//
//  CriarExpectativaViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 23/05/24.
//

import UIKit

class CriarExpectativaViewController: UIViewController {

    //MARK: CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Variáveis
    var textFieldDelegate = TextFieldDelegate()
    var textViewDelegate = TextViewDelegate()
    //Como eu quero o mesmo comportamento, posso utilizar os mesmos delegates
    
    var alreadySaved = false
    
    
    //MARK: Componentes
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var tituloTextField: UITextField = {
        
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 34.15)
        textField.tintColor = .white
        textField.textColor = .white
        textField.backgroundColor = .clear
        textField.textAlignment  = .left
        textField.layer.opacity = 0.3
        textField.attributedPlaceholder = NSAttributedString(
            string: "Escreve sua expectativa",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                        ]
        )
        
        
        return textField
    }()
    
    var nomeTextView: UITextView = {
        
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 24)
        textView.tintColor = .white
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment  = .left
        textView.textColor = .white
        textView.text = "Nome"
        textView.layer.opacity = 0.3
        
        return textView
        
    }()
    
    var textoTextView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 24)
        textView.tintColor = .white
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment  = .left
        textView.textColor = .white
        textView.text = "Eu espero que..."
        textView.layer.opacity = 0.3
        
        return textView
    }()
    
//    var collectionView: UICollectionView = {
//        
//        let collection = UICollectionView()
//        
//        
//        return collection
//        
//    }()
    

    //MARK: LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let titulo = tituloTextField.text else { return }
        guard let nome = nomeTextView.text else {return}
        guard let texto = textoTextView.text else {return}
        
        //Se o título ou a notas estiver vazio, não salva
        if titulo != "" && (texto != "O que você está pensando?" || texto != "") && !alreadySaved{
            addExpectativa(titulo: titulo, nome: <#T##String#>, texto: texto)
        }
        
        self.alreadySaved = true
    }
    
    //MARK: Funções UI
    
    func setUpUI(){
        initBackground()
        setTituloTextField()
        setNomeTextView()
        setTextoTextView()
    }
    
    func initBackground(){
        //Adiciono minha imagem ao fundo da tela e aplico os constraints
        self.view.addSubview(image)
        self.view.backgroundColor = .background
        //Aplicar as constraints
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            image.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        //Mandar uma layer abaixo
        image.layer.zPosition = -1
        
    }
    
    func setTituloTextField(){
        self.view.addSubview(tituloTextField)
        
        tituloTextField.delegate = textFieldDelegate
                
        NSLayoutConstraint.activate([
            tituloTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tituloTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tituloTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 0)
        ])
        tituloTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setNomeTextView(){
        self.view.addSubview(nomeTextView)
        
        //Esse é o delegate de UITextView
        nomeTextView.delegate = textViewDelegate
    }
    
    func setTextoTextView(){
        self.view.addSubview(textoTextView)
        
        self.textoTextView.delegate = textViewDelegate
        
        NSLayoutConstraint.activate([
            textoTextView.leadingAnchor.constraint(equalTo: tituloTextField.leadingAnchor),
            textoTextView.trailingAnchor.constraint(equalTo: tituloTextField.trailingAnchor),
            textoTextView.topAnchor.constraint(equalTo: tituloTextField.bottomAnchor, constant: 10),
            textoTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        textoTextView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
    }
    
    //MARK: Funções do CoreData
    func addExpectativa(titulo: String,nome: String, texto: String){
        //Criar uma expectativa nova
        let expectativa = Expectativa(context: self.context)
        expectativa.titulo = titulo
        expectativa.nome = nome
        expectativa.texto = texto
        
        //Salvar no dispositivo
        do {
            try self.context.save()
        }
        catch {
            print("Error ao salvar nova nota")
        }
    }
}


@available(iOS 17, *)
#Preview{
    
    return CriarExpectativaViewController()
    
}
