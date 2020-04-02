//
//  BrightAndKelvinTouchpadView.swift
//  Learn IOS
//  製作控制亮度與色溫元件
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class BrightAndKelvinTouchpadView: TouchpadView {
    
    private var brightAndKelvinListeners = [BrightAndKelvinListener]()
    private var brightView = UIView()
    private var kelvinView = UIView()
    private var currentBright: CGFloat = 0.0
    private var currentKelvin: CGFloat = 0.0
    private var viewWidth: CGFloat = 0.0
    private var viewHeight: CGFloat = 0.0
    private var isBrightViewDraw: Bool = false
    private var isKelvinViewDraw: Bool = false
    private var brightViewCenter: CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var kelvinViewCenter: CGPoint = CGPoint(x: 0.0, y: 0.0)

    public override init(frame: CGRect){
        super.init(frame: frame)
        self.addTouchpadListener(listener: self)
        self.viewWidth = frame.width
        self.viewHeight = frame.height
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func addBrightAndKelvinListener(listener: BrightAndKelvinListener) {
        if let index = brightAndKelvinListeners.firstIndex(where: {$0 === listener}) {
            brightAndKelvinListeners.remove(at: index)
        }
        
        brightAndKelvinListeners.append(listener)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if !isBrightViewDraw {
            isBrightViewDraw = true
            initBrightView()
            self.superview?.insertSubview(brightView, belowSubview: self)
        }
        
        if !isKelvinViewDraw {
            isKelvinViewDraw = true
            initKelvinView()
            self.superview?.insertSubview(kelvinView, belowSubview: self)
        }
        
        self.redrawBrightView()
        self.redrawKelvinView()
    }

    private func onTouch(location: CGPoint) {
        let x = location.x
        let y = location.y
        
        if x < 0.0 || x > viewWidth {
            return
        }
        
        if y < 0.0 || y > viewHeight {
            return
        }
        
        currentBright = x/viewWidth
        currentKelvin = 1 - y/viewHeight
        notifyBrightAndKelvinChange()
        let animator = UIViewPropertyAnimator(duration: 0.5, curve:  .linear, animations: {
            self.redrawBrightView()
            self.redrawKelvinView()
        })
        animator.startAnimation()
        
    }
    
    private func notifyBrightAndKelvinChange() {
        for listener in brightAndKelvinListeners {
            listener.change(bright: currentBright, kelvin: currentKelvin)
        }
    }
    
    private func initBrightView() {
        brightView.backgroundColor = UIColor.white
    }
    
    private func initKelvinView() {
        kelvinView.backgroundColor = UIColor.orange
    }
    
    private func redrawBrightView() {
        let width = (viewWidth - self.layer.cornerRadius)*currentBright
        let height = (viewHeight - self.layer.cornerRadius)*currentBright
        brightView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        brightView.center = self.center
        brightView.center.x -= viewWidth/10*(1-currentBright)
    }
    
    private func redrawKelvinView() {
        let width = (viewWidth - self.layer.cornerRadius)*currentKelvin*currentBright
        let height = (viewHeight - self.layer.cornerRadius)*currentKelvin*currentBright
        kelvinView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        kelvinView.center = self.center
        kelvinView.center.x += viewWidth/10*(1-currentKelvin)
    }
}

extension BrightAndKelvinTouchpadView: TouchpadListener {
    
    func locationChange(location: CGPoint) {
        onTouch(location: location)
    }
    
}

// MARK: Listener
protocol BrightAndKelvinListener: NSObjectProtocol {
    
    func change(bright: CGFloat, kelvin: CGFloat)
}
