//
//  ViewController.swift
//  TenSecondsChallenge
//
//  Created by VanJay on 2019/8/18.
//  Copyright © 2019 VanJay. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var timeLabel: UILabel!
    var startButton: UIButton!
    var timer: Timer!
    
    var currentTime = 0.00

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel = UILabel()
        timeLabel.text = "00:00"
        timeLabel.textColor = .red
        timeLabel.font = UIFont(name: "DBLCDTempBlack", size: 120)
        timeLabel.textAlignment = .center
        view.addSubview(timeLabel)
        
        startButton = UIButton(type: .custom)
        startButton.setTitle("开始", for: .normal)
        startButton.setTitle("停", for: .selected)
        startButton.setTitleColor(.red, for: .normal)
        startButton.setTitleColor(UIColor.red.withAlphaComponent(0.5), for: .highlighted)
        startButton.layer.cornerRadius = 80
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        startButton.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        startButton.addTarget(self, action: #selector(tappedStartButton(_:)), for: .touchUpInside)
        view.addSubview(startButton)
    }
    
    func startTimer() {
        timer = Timer(timeInterval: 0.01, target: self, selector: #selector(run), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
        timer.fire()
    }
    
    func stopTimer() {
        currentTime = 0.00
        timer.invalidate()
        timer = nil
    }
    
    @objc func tappedStartButton(_ btn: UIButton) {
        if (!btn.isSelected) {
            startTimer()
        } else {
            stopTimer()
        }
        
        btn.isSelected = !btn.isSelected
    }
    
    @objc func run() {
        
        currentTime += 0.01
        
        let str = String(format: "%.2f", currentTime)
        var strToShow: String
        if (currentTime >= 10) {
            strToShow = "\(str)"
        } else {
            strToShow = "0\(str)"
        }
        strToShow = strToShow.replacingOccurrences(of: ".", with: ":")
        
        timeLabel.text = strToShow
    }
    
    override func updateViewConstraints() {
        
        timeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview().offset(-2 * 15)
        }
        
        startButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(160)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-45)
        }
        
        super.updateViewConstraints()
    }
}

