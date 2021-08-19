//
//  CenterCollectionView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/19.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class CenterCollectionView: UICollectionView {
    
    private let widthScale: CGFloat
    private let heightScale: CGFloat

    public init(widthScale: CGFloat, heightScale: CGFloat) {
        self.widthScale = widthScale
        self.heightScale = heightScale
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.delegate = self
        self.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let inset = scrollView.frame.width * (1 - widthScale) * 0.25
        let itemWidth:CGFloat = scrollView.frame.width * widthScale + inset
        let contentOffset = scrollView.contentOffset.x
        let targetOffset = CGFloat(targetContentOffset.pointee.x)
        var newTargetOffset:CGFloat = 0.0

        if targetOffset > contentOffset {
            newTargetOffset = CGFloat(ceilf(Float(contentOffset / itemWidth))) * itemWidth
        } else {
            newTargetOffset = CGFloat(floorf(Float(contentOffset / itemWidth))) * itemWidth
        }

        if newTargetOffset < 0.0 {
            newTargetOffset = 0.0
        } else if newTargetOffset > scrollView.contentSize.width {
            newTargetOffset = scrollView.contentSize.width
        }
        
        targetContentOffset.pointee.x = newTargetOffset
        
        scrollView.setContentOffset(CGPoint(x: newTargetOffset, y: 0), animated: true)
    }
}

extension CenterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * widthScale, height: collectionView.frame.height * heightScale)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = collectionView.frame.width * (1 - widthScale) * 0.5
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.width * (1 - widthScale) * 0.25
    }
}
