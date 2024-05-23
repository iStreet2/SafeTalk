//
//  TestesViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 15/05/24.
//

import UIKit

class TestesViewController: UIViewController {
    
    
    //MARK: Componentes da nota
    private let capsuleBody: UIView = {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.backgroundColor = .cardPurple
        button.tintColor = .tintColor
        button.layer.cornerRadius = 49
        
        
        return button
    }()
    
    private let capsuleBodyBackground: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.backgroundColor = .cardBackPurple
        view.tintColor = .tintColor
        view.layer.cornerRadius = 49
        
        
        return view
        
    }()
    
    private let text: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Hoje eu acordei pensando em você, pensando em coisas que eu nem sei por quê"
        label.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 20)
        label.textColor = .white
        
        label.numberOfLines = 2
        
        return label
    }()
    
    private let capsuleDate: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .cardOrange
        view.tintColor = .tintColor
        view.layer.cornerRadius = 17
        
        return view
    }()
    
    private let capsuleDateBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .cardBackOrange
        view.tintColor = .tintColor
        view.layer.cornerRadius = 17
        
        return view
    }()
    
    private let dateText: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "11 de Maio de 2024"
        label.font = UIFont(name: fonts.twinkle.rawValue, size: 19)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
        
    }()
    
    
    //MARK: Componentes da Expectativa
    private let exBody: UIView = {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.backgroundColor = .cardPurple
        button.tintColor = .tintColor
        button.layer.cornerRadius = 49
        
        
        return button
    }()
    
    private let exBodyBackground: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.backgroundColor = .cardBackPurple
        view.tintColor = .tintColor
        view.layer.cornerRadius = 49
        
        
        return view
        
    }()
    
    private let exText: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "O que você espera de seu(sua) parceiro(a) quando diz que ama ele(a)?"
        label.font = UIFont(name: fonts.tsukimiSemiBold.rawValue, size: 20)
        label.textAlignment = .left
        label.textColor = .white
        
        label.numberOfLines = 9
        
        return label
    }()
    
    private let exDate: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .cardOrange
        view.tintColor = .tintColor
        view.layer.cornerRadius = 17
        
        return view
    }()
    
    private let exDateBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .cardBackOrange
        view.tintColor = .tintColor
        view.layer.cornerRadius = 17
        
        return view
    }()
    
    private let exDateText: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "11 de Maio de 2024"
        label.font = UIFont(name: fonts.twinkle.rawValue, size: 19)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
        
    }()
    
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        addExpectativa()
//        addNota()
        // Do any additional setup after loading the view.
    }
    
    func addExpectativa(){
        view.addSubview(exBody)
        NSLayoutConstraint.activate([
            exBody.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant:30),
            exBody.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant:-30),
            exBody.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            exBody.bottomAnchor.constraint(equalTo: self.exBody.topAnchor, constant: 300)
        ])
        
        view.addSubview(exBodyBackground)
        NSLayoutConstraint.activate([
            exBodyBackground.leadingAnchor.constraint(equalTo: self.exBody.leadingAnchor),
            exBodyBackground.trailingAnchor.constraint(equalTo: self.exBody.trailingAnchor),
            exBodyBackground.topAnchor.constraint(equalTo: self.exBody.topAnchor),
            exBodyBackground.bottomAnchor.constraint(equalTo: self.exBody.bottomAnchor, constant: 10)
        ])
        exBodyBackground.layer.zPosition = -1
        
        view.addSubview(exText)
        NSLayoutConstraint.activate([
            exText.leadingAnchor.constraint(equalTo: exBody.leadingAnchor, constant: 20),
            exText.trailingAnchor.constraint(equalTo: exBody.trailingAnchor, constant: -20),
            exText.topAnchor.constraint(equalTo: exBody.topAnchor, constant: 20),
//            exText.bottomAnchor.constraint(equalTo: exBody.bottomAnchor, constant: -10)
        
        ])
        
        view.addSubview(exDate)
        NSLayoutConstraint.activate([
            exDate.leadingAnchor.constraint(equalTo: exBody.leadingAnchor, constant: 60),
            exDate.trailingAnchor.constraint(equalTo: exBody.trailingAnchor, constant: -60),
            exDate.topAnchor.constraint(equalTo: exBody.topAnchor, constant: -20),
            exDate.bottomAnchor.constraint(equalTo: exBody.topAnchor, constant: 10)
        
        ])
        exDate.layer.zPosition = 1
        
        view.addSubview(exDateBackground)
        NSLayoutConstraint.activate([
            exDateBackground.leadingAnchor.constraint(equalTo: exDate.leadingAnchor),
            exDateBackground.trailingAnchor.constraint(equalTo: exDate.trailingAnchor),
            exDateBackground.topAnchor.constraint(equalTo: exDate.topAnchor),
            exDateBackground.bottomAnchor.constraint(equalTo: exDate.bottomAnchor,constant: 5)
        ])
        
        view.addSubview(exDateText)
        NSLayoutConstraint.activate([
            exDateText.leadingAnchor.constraint(equalTo: exDate.leadingAnchor),
            exDateText.trailingAnchor.constraint(equalTo: exDate.trailingAnchor),
            exDateText.topAnchor.constraint(equalTo: exDate.topAnchor, constant: 5),
            exDateText.bottomAnchor.constraint(equalTo: exDate.bottomAnchor, constant: -5)
        ])
        exDateText.layer.zPosition = 1
    }
    
    func addNota(){
        view.addSubview(capsuleBody)
        NSLayoutConstraint.activate([
            capsuleBody.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant:30),
            capsuleBody.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant:-30),
            capsuleBody.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            capsuleBody.bottomAnchor.constraint(equalTo: self.capsuleBody.topAnchor, constant: 100)
        ])
        
        view.addSubview(capsuleBodyBackground)
        NSLayoutConstraint.activate([
            capsuleBodyBackground.leadingAnchor.constraint(equalTo: self.capsuleBody.leadingAnchor),
            capsuleBodyBackground.trailingAnchor.constraint(equalTo: self.capsuleBody.trailingAnchor),
            capsuleBodyBackground.topAnchor.constraint(equalTo: self.capsuleBody.topAnchor),
            capsuleBodyBackground.bottomAnchor.constraint(equalTo: self.capsuleBody.bottomAnchor, constant: 10)
        ])
        capsuleBodyBackground.layer.zPosition = -1
        
        view.addSubview(text)
        NSLayoutConstraint.activate([
            text.leadingAnchor.constraint(equalTo: capsuleBody.leadingAnchor, constant: 20),
            text.trailingAnchor.constraint(equalTo: capsuleBody.trailingAnchor, constant: -20),
            text.topAnchor.constraint(equalTo: capsuleBody.topAnchor, constant: 10),
            text.bottomAnchor.constraint(equalTo: capsuleBody.bottomAnchor, constant: -10)
        
        ])
        
        view.addSubview(capsuleDate)
        NSLayoutConstraint.activate([
            capsuleDate.leadingAnchor.constraint(equalTo: capsuleBody.leadingAnchor, constant: 60),
            capsuleDate.trailingAnchor.constraint(equalTo: capsuleBody.trailingAnchor, constant: -60),
            capsuleDate.topAnchor.constraint(equalTo: capsuleBody.topAnchor, constant: -20),
            capsuleDate.bottomAnchor.constraint(equalTo: capsuleBody.topAnchor, constant: 10)
        
        ])
        capsuleDate.layer.zPosition = 1
        
        view.addSubview(capsuleDateBackground)
        NSLayoutConstraint.activate([
            capsuleDateBackground.leadingAnchor.constraint(equalTo: capsuleDate.leadingAnchor),
            capsuleDateBackground.trailingAnchor.constraint(equalTo: capsuleDate.trailingAnchor),
            capsuleDateBackground.topAnchor.constraint(equalTo: capsuleDate.topAnchor),
            capsuleDateBackground.bottomAnchor.constraint(equalTo: capsuleDate.bottomAnchor,constant: 5)
        ])
        
        view.addSubview(dateText)
        NSLayoutConstraint.activate([
            dateText.leadingAnchor.constraint(equalTo: capsuleDate.leadingAnchor),
            dateText.trailingAnchor.constraint(equalTo: capsuleDate.trailingAnchor),
            dateText.topAnchor.constraint(equalTo: capsuleDate.topAnchor, constant: 5),
            dateText.bottomAnchor.constraint(equalTo: capsuleDate.bottomAnchor, constant: -5)
        ])
        dateText.layer.zPosition = 1
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

@available(iOS 17, *)
#Preview{
    return TestesViewController()
}
