//
//  ExpectativaCollectionDataSource.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 23/05/24.
//

import UIKit

class ExpectativaCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var expectativas: [Expectativa]?
    
    init(expectativas: [Expectativa]?) {
        self.expectativas = expectativas
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return expectativas?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpectativaCollectionViewCell.identifier, for: indexPath) as? ExpectativaCollectionViewCell else {
            fatalError("Falhou em tentar pegar minha celula customizada na ExpectativasViewController")
        }
        
        let date = Date()

        let dataString = date.formatted(
        
            Date.FormatStyle()
                .locale(Locale(identifier: "pt-BR"))
            
                .day(.twoDigits)
                .month(.wide)
                .year()
        )
        
        //TODO: Pegar notas e datas do CoreData
        let exTitulo = self.expectativas?[indexPath.row].titulo ?? "error"
        var exDate = dataString
        
        //Se o titulo for algum desses
        if exTitulo == "O que você espera de seu(sua) parceiro(a) quando diz que ama ele(a)?" || exTitulo == "O que você espera de seu(sua) parceiro(a) quando vocês saem para ir em um rolê com amigos?" || exTitulo == "O que você espera de seu(sua) parceiro(a) quando um de vocês está passando por dificuldade financeira?" || exTitulo == "O que você espera de seu(sua) parceiro(a) quando você diz que está triste?" {
            //Ao construir a celula, a data vai ser "Sugestão"
            exDate = "Sugestão"
        }
    
        
        cell.configure(exTitulo, exDate)
        
        return cell
    }
    
}
