//
//  TabBarController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    //inicializo minha variável de imagem do fundo
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
        initTabBar()
        configTabBar()
    }
    
    func initTabBar(){
        //Vou inicializar minha TabBar com as cores dos items e dela
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .tabBarItemOrange
        self.tabBar.backgroundColor = .white

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
    
    func configTabBar(){
        //Inicialização da primeira View no primeiro item da TabBar
        let notasViewController = UINavigationController(rootViewController: NotasViewController())
        notasViewController.tabBarItem.title = "Notas"
        notasViewController.tabBarItem.image = UIImage(systemName: "book.closed")
        notasViewController.tabBarItem.selectedImage = UIImage(systemName: "book.closed.fill")
//        notasViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: fonts.twinkle.rawValue, size: 20)!]
        
        //Inicialização da segunda View no segundo item da TabBar
        let gravacoesViewController = UINavigationController(rootViewController: GravacoesViewController())
        gravacoesViewController.tabBarItem.title = "Gravações"
        gravacoesViewController.tabBarItem.image = UIImage(systemName: "mic")
        gravacoesViewController.tabBarItem.selectedImage = UIImage(systemName: "mic.fill")
        
        //Inicialização da terceira View no terceito item da TabBar
        let expectativasViewController = UINavigationController(rootViewController: ExpectativasViewController())
        expectativasViewController.tabBarItem.title = "Expectativas"
        expectativasViewController.tabBarItem.image = UIImage(systemName: "person.2")
        expectativasViewController.tabBarItem.selectedImage = UIImage(systemName: "person.2.fill")
        
        self.setViewControllers([notasViewController,gravacoesViewController,expectativasViewController], animated: true)
    }

}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}
