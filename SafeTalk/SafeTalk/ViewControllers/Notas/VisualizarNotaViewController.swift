//
//  VisualizarNotaViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 15/05/24.
//

import UIKit

class VisualizarNotaViewController: UIViewController {
    
    //inicializo minha variável de imagem do fundo
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Título"
        label.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 34.15)
        label.textColor = .white
        
        return label
    }()
    
    let notaLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "O que você está pensando agora?"
        label.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 24)
        label.textAlignment = .left
        label.numberOfLines = 100
        label.textColor = .white
        
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
        setTitle()
        setNote()
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
        self.view.addSubview(tituloLabel)
        
        NSLayoutConstraint.activate([
            tituloLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tituloLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tituloLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    func setNote(){
        self.view.addSubview(notaLabel)
        
        NSLayoutConstraint.activate([
            notaLabel.leadingAnchor.constraint(equalTo: tituloLabel.leadingAnchor),
            notaLabel.trailingAnchor.constraint(equalTo: tituloLabel.trailingAnchor),
            notaLabel.topAnchor.constraint(equalTo: tituloLabel.bottomAnchor, constant: 10),
        ])
    }
    

}

@available(iOS 17, *)
#Preview {
    VisualizarNotaViewController()
}
