//
//  ScanBleBottomSheetViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ScanBleBottomSheetViewController: UIViewController {

    @IBOutlet weak var partialView: UIView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var scanButton: UIButton!
    
    var scanTableView: UITableView!
    
    enum State {
        case partial
        case full
    }
    
    let cornerRadius: CGFloat = 10
    let fullViewYPosition: CGFloat = 100
    var partialViewHeight: CGFloat = 70
    var partialViewYPosition: CGFloat = 0
    var currentState: State = .partial
    
    var fakeData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFakeData()
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
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        partialViewHeight = partialView.frame.height
        partialViewYPosition = UIScreen.main.bounds.height - fullViewYPosition - partialViewHeight + getBottomSafeHeight()
        roundView()
        initPartialView()
        initTableVIew()
    }
    
    func getBottomSafeHeight() -> CGFloat {
        return (UIScreen.main.bounds.height == view.frame.height ? 0 : 34) + cornerRadius
    }
    
    func roundView() {
        let path = UIBezierPath(roundedRect: partialView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        partialView.layer.mask = mask
        view.layer.cornerRadius = cornerRadius
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
    
    func initTableVIew(){
        scanTableView = UITableView(frame: CGRect(
        x: 0, y: 0,
        width: tableViewContainer.frame.width,
        height: tableViewContainer.frame.height),
        style: .plain)
        
        scanTableView.register(UINib(nibName: "ScanBleTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        scanTableView.delegate = self
        scanTableView.dataSource = self

        // 分隔線的樣式
        scanTableView.separatorStyle = .singleLine

        // 分隔線的間距 四個數值分別代表 上、左、下、右 的間距
        scanTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        // 是否可以點選 cell
        scanTableView.allowsSelection = true

        // 是否可以多選 cell
        scanTableView.allowsMultipleSelection = false

        // 加入到畫面中
        tableViewContainer.addSubview(scanTableView)
    }

    @IBAction func scan(_ sender: Any) {
        print("Start Scan")
    }
    
    func makeFakeData(){
        fakeData.append("Device1")
    }
}

//MARK: - TableView
extension ScanBleBottomSheetViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScanBleTableViewCell
        
        cell.nameLabel.text = String.init(format: "Device Name: %@", fakeData[indexPath.row])
        //cell.addressLabel.text = peripheral.peripheral.identifier.uuidString
        //cell.distanceLabel.text = peripheral.rssi.stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String.init(format: "Select device Name: %@", fakeData[indexPath.row]))
    }
}
