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
    
    var notas: [Nota]?

    
    init(navigationController: UINavigationController?, notas: [Nota]?) {
        self.navigationController = navigationController
        self.notas = notas
    }
    
    func navigate(nota: Nota){
        let view = VisualizarNotaViewController()
        view.nota = nota
        navigationController?.pushViewController(view, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let nota = notas?[indexPath.row] else {return}
        
        navigate(nota: nota)
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
