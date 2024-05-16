//
//  NotasViewCollectionDataSource.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 15/05/24.
//

import Foundation
import UIKit

class NotasCollectionDataSource: NSObject, UICollectionViewDataSource{
    
    var notasParaTeste:[String]
    var datasParaTeste = ["11 de Maio de 2024"]
    
    //Vamos trocar aqui os notas para testes para as notas reais do CoreData:
    
    
    init(notasParaTeste: [String]) {
        self.notasParaTeste = notasParaTeste
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: Pegar a quantidade de notas do CoreData
        
        return self.notasParaTeste.count
    }
    
    //Aqui eu crio minhas celulas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotaCollectionViewCell.identifier, for: indexPath) as? NotaCollectionViewCell else {
            fatalError("Falhou em tentar pegar minha celula customizada na NotasViewController")
        }
        
        
        //TODO: Pegar notas e datas do CoreData
        let noteText = self.notasParaTeste[indexPath.row]
        let noteDate = self.datasParaTeste[0]
        
        cell.configure(noteText, noteDate)
        
        return cell
    }
    
    
}
