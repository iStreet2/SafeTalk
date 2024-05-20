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
//    var notasParaTeste: [String]
    
    var notas: [Nota]?

    
    init(navigationController: UINavigationController?, notas: [Nota]?) {
        self.navigationController = navigationController
        self.notas = notas
    }
    
    func navigate(titulo: String, nota: String){
        let container = VisualizarNotaViewController()
        container.notaLabel.text = nota
        container.tituloLabel.text = titulo
        navigationController?.pushViewController(container, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigate(titulo: notas?[indexPath.row].titulo ?? "error", nota: notas?[indexPath.row].texto ?? "error")
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
