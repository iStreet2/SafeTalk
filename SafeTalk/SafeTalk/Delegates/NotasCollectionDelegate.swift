//
//  NotaCollectionDElegate.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 15/05/24.
//

import Foundation
import UIKit

class NotasCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var navigationController: UINavigationController?
    var notasParaTeste: [String]

    
    init(navigationController: UINavigationController?, notasParaTeste: [String]) {
        self.navigationController = navigationController
        self.notasParaTeste = notasParaTeste
    }
    
    func navigate(nota: String){
        let container = VisualizarNotaViewController()
        container.notaLabel.text = nota
        container.tituloLabel.text = "Funcionando"
        navigationController?.pushViewController(container, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigate(nota: notasParaTeste[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 121)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
}

@available(iOS 17, *)
#Preview {
    return TabBarController()
}
