//
//  BottomSheetViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/13.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var partialView: UIView!
    
    enum State {
        case partial
        case full
    }
    
    let fullViewYPosition: CGFloat = 100
    var partialViewHeight: CGFloat = 70
    var partialViewYPosition: CGFloat = 0
    var currentState: State = .partial
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .partial)
        })
    }
    
    private func moveView(state: State) {
        currentState = state
        let yPosition = state == .partial ? partialViewYPosition : fullViewYPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }

    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY
        
        if (minY + translation.y >= fullViewYPosition) && (minY + translation.y <= partialViewYPosition) {
            view.frame = CGRect(x: 0, y: minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, animations: {
               let state: State = recognizer.velocity(in: self.view).y >= 0 ? .partial : .full
               self.moveView(state: state)
            }, completion: nil)
        }
    }
    
    // MARK: - Init View
    func initView(){
        partialViewHeight = partialView.frame.height
        partialViewYPosition = UIScreen.main.bounds.height - fullViewYPosition - partialViewHeight
        roundView()
        initPartialView()
    }
    
    func roundView() {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }

    func initPartialView(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickPartialView))
        partialView.addGestureRecognizer(gesture)
    }
    
    @objc func clickPartialView(sender : UITapGestureRecognizer) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, animations: {
           self.moveView(state: self.currentState == .partial ? .full : .partial)
        }, completion: nil)
    }
}
