//
//  ExpectativaCollectionViewCell.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 23/05/24.
//

import UIKit

class ExpectativaCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ExpectativaCollectionViewCell"
    
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
    
    private let exTitulo: UILabel = {
        
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
        
        label.text = "Sugestão"
        label.font = UIFont(name: fonts.twinkle.rawValue, size: 19)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
        
    }()
    
    public func configure(_ titulo: String, _ date: String){
        self.exTitulo.text = titulo
        self.exDateText.text = date
        self.addExpectativa()
    }
    
    func addExpectativa(){
        addSubview(exBody)
        NSLayoutConstraint.activate([
            exBody.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:30),
            exBody.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:-30),
            exBody.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            exBody.bottomAnchor.constraint(equalTo: self.exBody.topAnchor, constant: 300)
        ])
        
        addSubview(exBodyBackground)
        NSLayoutConstraint.activate([
            exBodyBackground.leadingAnchor.constraint(equalTo: self.exBody.leadingAnchor),
            exBodyBackground.trailingAnchor.constraint(equalTo: self.exBody.trailingAnchor),
            exBodyBackground.topAnchor.constraint(equalTo: self.exBody.topAnchor),
            exBodyBackground.bottomAnchor.constraint(equalTo: self.exBody.bottomAnchor, constant: 10)
        ])
        exBodyBackground.layer.zPosition = -1
        
        addSubview(exTitulo)
        NSLayoutConstraint.activate([
            exTitulo.leadingAnchor.constraint(equalTo: exBody.leadingAnchor, constant: 20),
            exTitulo.trailingAnchor.constraint(equalTo: exBody.trailingAnchor, constant: -20),
            exTitulo.topAnchor.constraint(equalTo: exBody.topAnchor, constant: 20),
//            exText.bottomAnchor.constraint(equalTo: exBody.bottomAnchor, constant: -10)
        
        ])
        
        addSubview(exDate)
        NSLayoutConstraint.activate([
            exDate.leadingAnchor.constraint(equalTo: exBody.leadingAnchor, constant: 60),
            exDate.trailingAnchor.constraint(equalTo: exBody.trailingAnchor, constant: -60),
            exDate.topAnchor.constraint(equalTo: exBody.topAnchor, constant: -20),
            exDate.bottomAnchor.constraint(equalTo: exBody.topAnchor, constant: 10)
        
        ])
        exDate.layer.zPosition = 1
        
        addSubview(exDateBackground)
        NSLayoutConstraint.activate([
            exDateBackground.leadingAnchor.constraint(equalTo: exDate.leadingAnchor),
            exDateBackground.trailingAnchor.constraint(equalTo: exDate.trailingAnchor),
            exDateBackground.topAnchor.constraint(equalTo: exDate.topAnchor),
            exDateBackground.bottomAnchor.constraint(equalTo: exDate.bottomAnchor,constant: 5)
        ])
        
        addSubview(exDateText)
        NSLayoutConstraint.activate([
            exDateText.leadingAnchor.constraint(equalTo: exDate.leadingAnchor),
            exDateText.trailingAnchor.constraint(equalTo: exDate.trailingAnchor),
            exDateText.topAnchor.constraint(equalTo: exDate.topAnchor, constant: 5),
            exDateText.bottomAnchor.constraint(equalTo: exDate.bottomAnchor, constant: -5)
        ])
        exDateText.layer.zPosition = 1
    }
    
}
