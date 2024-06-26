//
//  TabBarController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 13/05/24.
//

import LocalAuthentication
import UIKit

class TabBarController: UITabBarController {
    
    //Variáveis
    var isAuthenticated: authenticationState = .authenticating
    
    //Componentes
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isAuthenticated == .authenticating {
            initBackground()
            initBlur()
            
            //MARK: Para DEBUG TIRAR DEPOIIISS
            isAuthenticated = .authenticated
            setElements()
            
//            authenticateTapped() { result in
//                
//                if result == true{
//                    if self.isAuthenticated == .authenticated {
//                        self.setElements()
//                    }
//                }
//                
//            }
        }
    }
    
    func setElements(){
        initTabBar()
        configTabBar()
        removeBlur()
    }
    
    func initTabBar(){
        //Vou inicializar minha TabBar com as cores dos items e dela
        
        
        self.tabBar.tintColor = .tabBarItemOrange
        self.tabBar.barTintColor = .white
       
        self.tabBar.isTranslucent = false
        
        self.tabBar.backgroundColor = .white
        
        self.tabBar.unselectedItemTintColor = .tabBarItemOrange
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
    
    func initBlur(){
        blurEffectView.frame = view.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(blurEffectView)
    }
    
    func removeBlur(){
        blurEffectView.removeFromSuperview()
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

}

@available(iOS 17.0, *)
#Preview{
    return TabBarController()
}

enum authenticationState {
    
    case authenticated
    case authenticating
    case unauthenticated
    
}
