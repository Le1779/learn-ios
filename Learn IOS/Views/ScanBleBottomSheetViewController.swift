//
//  ScanBleBottomSheetViewController.swift
//  Learn IOS
//  藍芽連線的Bottom Sheet，搜尋裝置，點擊列表連接裝置，顯示連線狀態
//  Created by Kevin Le on 2020/3/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ScanBleBottomSheetViewController: UIViewController {

    @IBOutlet weak var partialView: UIView!
    @IBOutlet weak var tableViewContainer: UIView!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var connectingProgress: UIActivityIndicatorView!
    @IBOutlet weak var connectStateLabel: UILabel!
    
    private var scanTableView: UITableView!
    
    enum State {
        case partial
        case full
    }
    
    let cornerRadius: CGFloat = 10
    let fullViewYPosition: CGFloat = 100
    var partialViewHeight: CGFloat = 70
    var partialViewYPosition: CGFloat = 0
    var currentState: State = .partial
    
    var scanDevices = [String: BleDevice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BleHelper.instance.addScanListener(listener: self)
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .partial)
        })
    }
    
    override func viewDidLayoutSubviews() {
        scanTableView.frame = CGRect(x: 0, y: 0, width: tableViewContainer.frame.width, height: tableViewContainer.frame.height)
    }
    
    public func getPartialViewHeight() -> (CGFloat){
        return partialViewHeight
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
        scanTableView = UITableView(
            frame: CGRect(x: 0, y: 0, width: tableViewContainer.frame.width, height: 100),
            style: .plain
        )
        
        scanTableView.register(UINib(nibName: "ScanBleTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        scanTableView.delegate = self
        scanTableView.dataSource = self
        scanTableView.separatorStyle = .singleLine
        scanTableView.rowHeight = 80
        scanTableView.backgroundColor = UIColor.white
        tableViewContainer.addSubview(scanTableView)
    }

    @IBAction func scan(_ sender: Any) {
        BleHelper.instance.startScan()
    }
}

//MARK: - TableView
extension ScanBleBottomSheetViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scanDevices.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScanBleTableViewCell
        cell.backgroundColor = UIColor.white
        
        let device = Array(scanDevices.values)[indexPath.row]
        
        cell.nameLabel.text = device.name
        
        //cell.addressLabel.text = peripheral.peripheral.identifier.uuidString
        //cell.distanceLabel.text = peripheral.rssi.stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        connectingProgress.startAnimating()
        //connectStateLabel.text = "正在連線(" + fakeData[indexPath.row] + ")"
        //print(String.init(format: "Select device Name: %@", fakeData[indexPath.row]))
    }
    
}

extension ScanBleBottomSheetViewController: ScanListener{
    
    func getTag() -> (String) {
        return "ScanBleBottomSheetViewController"
    }
    
    func findNewDevice(device: BleDevice){
        print("findNewDevice N:\(device.name), M:\(device.mac), R:\(device.rssi)")
        scanDevices[device.mac] = device
        self.scanTableView.reloadData()
    }
    
    func updateRssi(mac: String, rssi:NSNumber){
        print("updateRssi M:\(mac), R:\(rssi)")
        scanDevices[mac]?.rssi = rssi
    }
}
