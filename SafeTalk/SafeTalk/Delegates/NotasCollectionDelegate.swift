//
//  NotaCollectionDElegate.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 15/05/24.
//

import Foundation
import UIKit

class NotasCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            navigateCollection(titulo: collectionView.cellForItem(at: indexPath)., nota: collectionView.cellForItem(at: indexPath).getNota())
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 121)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
