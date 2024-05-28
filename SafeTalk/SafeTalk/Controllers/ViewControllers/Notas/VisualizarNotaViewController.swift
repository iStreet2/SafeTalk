//
//  VisualizarNotaViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 15/05/24.
//

import UIKit

class VisualizarNotaViewController: UIViewController {
    
    //Coisas do CoreData
    //Referencia para o objeto contexto
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Variáveis
    
    var nota: Nota?
    
    var uiTextViewDelegate = TextViewDelegate()
    
    var alreadySaved = false
    
    //Componentes
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var tituloLabel: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 34.15)
        label.textColor = .white
        
        return label
    }()
    
    var textoLabel: UITextView = {
        
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 24)
        label.textAlignment = .left
        label.tintColor = .white
        label.textColor = .white
        label.backgroundColor = .clear
//        label.numberOfLines = 100
        label.textColor = .white
        
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
        setTitle()
        setNote()
        setDeleteButton()
        self.title = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let titulo = tituloLabel.text else { return }
        guard let texto = textoLabel.text else {return}
        
        //Se o título ou a notas estiver vazio, não salva
        if titulo != "" && (texto != "O que você está pensando?" || texto != "") && !alreadySaved{
            saveData()
        }
        
        self.alreadySaved = true
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
    
    func setTitle(){
        tituloLabel.text = nota?.titulo
        
        //MARK: TIRAR DEPOIS
//        tituloLabel.text = "Teste"
        
        
        self.view.addSubview(tituloLabel)
        NSLayoutConstraint.activate([
            tituloLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tituloLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 0)
        ])
        tituloLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setNote(){
       textoLabel.text = nota?.texto
        
        //MARK: TIRAR DEPOIS
//       textoLabel.text = "Teste muito maneiro para testar as paradas"
        
        self.view.addSubview(textoLabel)
        self.textoLabel.delegate = uiTextViewDelegate
        
        NSLayoutConstraint.activate([
           textoLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
           textoLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),
           textoLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 10),
           textoLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
       textoLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    func setDeleteButton(){
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteData))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func saveData(){
        guard let nota = nota else {return}
        
        nota.titulo = tituloLabel.text
        nota.texto = textoLabel.text
        
        do {
            try self.context.save()
        } catch {
            print("Error ao salvar novos dados")
        }
    }
    
    @objc func deleteData(){
        
        let alert = UIAlertController(title: "Apagar", message: "Quer mesmo apagar sua nota?", preferredStyle: .alert)
        
        
        guard let notaADeletar = nota else {return}
        
        let deleteData = UIAlertAction(title: "Deletar", style: .destructive) { action in
            
            
            self.context.delete(notaADeletar)
            
            do {
                try self.context.save()
            } catch{
                print("Erro ao deletar o dado")
            }
            self.navigationController?.popViewController(animated: true)
            
            
            
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(deleteData)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }

}

@available(iOS 17, *)
#Preview {
    VisualizarNotaViewController()
}
