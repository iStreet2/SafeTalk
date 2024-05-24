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
    
    //Variáveis
    var textFieldDelegate = TextFieldDelegate()
    var textViewDelegate = TextViewDelegate()
    
    var alreadySaved = false
    
    
    //Componentes
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
            string: "Título",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                        ]
        )
        
        
        return textField
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
        guard let texto = textoTextView.text else {return}
        
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
    
    func setTextoTextField(){
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
