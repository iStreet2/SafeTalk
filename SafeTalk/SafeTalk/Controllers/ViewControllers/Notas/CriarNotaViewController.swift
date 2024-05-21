//
//  CriarNotaViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 14/05/24.
//

import UIKit
import CoreData

class CriarNotaViewController: UIViewController {
    
    //Coisas do CoreData
    //Referencia para o objeto contexto
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //A nota que vou escrever
    var nota: Nota?
    
    //Variáveis
    var uiTituloViewDelegate = CriarNotaViewTituloDelegate()
    var uiTextoViewDelegate = CriarNotaViewTextoDelegate()
    
    var alreadySaved = false
    
    
    //Componentes
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Hello world!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        
        return label
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
            string: "Título",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                        ]
        )
        
        
        return textField
    }()
    
    var textoTextField: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 24)
        textView.tintColor = .white
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment  = .left
        textView.textColor = .white
        textView.text = "O que você está pensando?"
        textView.layer.opacity = 0.3
        
        return textView
    }()
    

    //Ciclo de vida da minha tela
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let titulo = tituloTextField.text else { return }
        guard let texto = textoTextField.text else {return}
        
        //Se o título ou a notas estiver vazio, não salva
        if titulo != "" && (texto != "O que você está pensando?" || texto != "") && !alreadySaved{
            addNota(titulo: titulo, texto: texto)
        }
        
        self.alreadySaved = true
    }
    
    //Funções dos componentes
    
    func setUpUI(){
        initBackground()
        setTituloTextField()
        setTextoTextField()
//        setHelloWorld()
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
    
    func setHelloWorld(){
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func setTituloTextField(){
        self.view.addSubview(tituloTextField)
        
        tituloTextField.delegate = uiTituloViewDelegate
                
        NSLayoutConstraint.activate([
            tituloTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tituloTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tituloTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 0)
        ])
        tituloTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setTextoTextField(){
        self.view.addSubview(textoTextField)
        
        self.textoTextField.delegate = uiTextoViewDelegate
        
        NSLayoutConstraint.activate([
            textoTextField.leadingAnchor.constraint(equalTo: tituloTextField.leadingAnchor),
            textoTextField.trailingAnchor.constraint(equalTo: tituloTextField.trailingAnchor),
            textoTextField.topAnchor.constraint(equalTo: tituloTextField.bottomAnchor, constant: 10),
            textoTextField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        textoTextField.setContentHuggingPriority(.defaultLow, for: .vertical)
        
    }
    
    //Funções do CoreData
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

}

@available(iOS 17.0, *)
#Preview{
    return CriarNotaViewController()
}
