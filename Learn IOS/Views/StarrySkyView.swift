//
//  StarrySkyView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/5/6.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class StarrySkyView: UIView {
    
    let skyColor: UIColor = UIColor(red: 0.03, green: 0.06, blue: 0.23, alpha: 1)
    var stars: [UIView] = []
    let starNum: Int = 20
    let starMinWidth: Int = 5
    let starMaxWidth: Int = 8
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        drawBackgroundColor()
        //drawStars()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func drawBackgroundColor() {
        self.backgroundColor = skyColor
    }
    
    func drawStars() {
        for _ in 1...starNum {
            makeStar()
        }
        startAnimations()
    }
    
    func makeStar() {
        let viewWidth = self.bounds.width
        let viewHeight = self.bounds.height
        print("width\(viewWidth) height\(viewHeight)")
        let starWidth = Int.random(in: starMinWidth...starMaxWidth)
        let star = UIView()
        star.frame = CGRect(x: Int.random(in: starMaxWidth...Int(viewWidth)), y: Int.random(in: starMaxWidth...Int(viewHeight)), width: starWidth, height: starWidth)
        print("frame\(star.frame)")
        star.backgroundColor = .white
        star.layer.cornerRadius = 5
        star.alpha = 0.0
        self.addSubview(star)
        stars.append(star)
    }
    
    func startAnimations() {
        stars.forEach { star in
            UIView.animate(withDuration: TimeInterval(Int.random(in: 5...10)), delay: 0, options: [.repeat, .autoreverse], animations: {
                star.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func randomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
