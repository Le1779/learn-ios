//
//  UIImage.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/9/24.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImage(_ dimension: CGFloat) -> UIImage {
        var width: CGFloat
        var height: CGFloat

        let size = self.size
        let aspectRatio =  size.width/size.height

        if aspectRatio > 1 {
            width = dimension
            height = dimension / aspectRatio
        } else {
            height = dimension
            width = dimension * aspectRatio
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return resizeImage
    }
    
}
