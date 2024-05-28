//
//  ExpectativaCollectionDelegate.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 23/05/24.
//

import UIKit

class ExpectativaCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var navigationController: UINavigationController?
    var expectativas: [Expectativa]?
    
    init(navigationController: UINavigationController? = nil, expectativas: [Expectativa]? = nil) {
        self.navigationController = navigationController
        self.expectativas = expectativas
    }
    
    //TODO: Criar view de visualizar expectativa para continuar esse codigo
//    func navigate(expectativa: Expectativa){
//        let view = VisualizarExpectativaViewController()
//        view.expectativa = expectativa
//        navigationController?.pushViewController(view, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let expectativa = expectativas?[indexPath.row] else {return}
        print(expectativa)
        
//        navigate(expectativa: expectativa)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
}
