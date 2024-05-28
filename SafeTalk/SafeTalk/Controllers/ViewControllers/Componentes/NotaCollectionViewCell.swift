//
//  NotaCollectionViewCell.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 14/05/24.
//

import UIKit

class NotaCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NotaCollectionViewCell"
    
    private let capsuleBody: UIView = {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.backgroundColor = .cardPurple
        button.tintColor = .tintColor
        button.layer.cornerRadius = 49
        
        
        return button
    }()
    
    private let capsuleBodyBackground: UIView = {
       
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.backgroundColor = .cardBackPurple
        button.tintColor = .tintColor
        button.layer.cornerRadius = 49
        
        
        return button
        
    }()
    
    private let noteLabel: UILabel = {
        
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
    
    private let dateLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "11 de Maio de 2024"
        label.font = UIFont(name: fonts.twinkle.rawValue, size: 19)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
        
    }()
    
    public func configure(_ note: String,_ date: String){
        self.noteLabel.text = note
        self.dateLabel.text = date
        self.addNotas()
    }
    
    private func addNotas() {        
        self.addSubview(capsuleBody)
        NSLayoutConstraint.activate([
            capsuleBody.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:30),
            capsuleBody.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:-30),
            capsuleBody.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            capsuleBody.bottomAnchor.constraint(equalTo: self.capsuleBody.topAnchor, constant: 100)
        ])
        
        self.addSubview(capsuleBodyBackground)
        NSLayoutConstraint.activate([
            capsuleBodyBackground.leadingAnchor.constraint(equalTo: self.capsuleBody.leadingAnchor),
            capsuleBodyBackground.trailingAnchor.constraint(equalTo: self.capsuleBody.trailingAnchor),
            capsuleBodyBackground.topAnchor.constraint(equalTo: self.capsuleBody.topAnchor),
            capsuleBodyBackground.bottomAnchor.constraint(equalTo: self.capsuleBody.bottomAnchor, constant: 10)
        ])
        capsuleBodyBackground.layer.zPosition = -1
        
        self.addSubview(noteLabel)
        NSLayoutConstraint.activate([
            noteLabel.leadingAnchor.constraint(equalTo: capsuleBody.leadingAnchor, constant: 20),
            noteLabel.trailingAnchor.constraint(equalTo: capsuleBody.trailingAnchor, constant: -20),
            noteLabel.topAnchor.constraint(equalTo: capsuleBody.topAnchor, constant: 10),
            noteLabel.bottomAnchor.constraint(equalTo: capsuleBody.bottomAnchor, constant: -10)
        
        ])
        
        self.addSubview(capsuleDate)
        NSLayoutConstraint.activate([
            capsuleDate.leadingAnchor.constraint(equalTo: capsuleBody.leadingAnchor, constant: 60),
            capsuleDate.trailingAnchor.constraint(equalTo: capsuleBody.trailingAnchor, constant: -60),
            capsuleDate.topAnchor.constraint(equalTo: capsuleBody.topAnchor, constant: -20),
            capsuleDate.bottomAnchor.constraint(equalTo: capsuleBody.topAnchor, constant: 10)
        
        ])
        capsuleDate.layer.zPosition = 1
        
        self.addSubview(capsuleDateBackground)
        NSLayoutConstraint.activate([
            capsuleDateBackground.leadingAnchor.constraint(equalTo: capsuleDate.leadingAnchor),
            capsuleDateBackground.trailingAnchor.constraint(equalTo: capsuleDate.trailingAnchor),
            capsuleDateBackground.topAnchor.constraint(equalTo: capsuleDate.topAnchor),
            capsuleDateBackground.bottomAnchor.constraint(equalTo: capsuleDate.bottomAnchor,constant: 5)
        ])
        
        self.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: capsuleDate.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: capsuleDate.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: capsuleDate.topAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: capsuleDate.bottomAnchor, constant: -5)
        ])
        dateLabel.layer.zPosition = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dateLabel.text = nil
        self.noteLabel.text = nil
    }
    
    
}

