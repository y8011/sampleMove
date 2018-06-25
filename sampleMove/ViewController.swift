//
//  ViewController.swift
//  sampleMove
//
//  Created by yuka on 2018/06/25.
//  Copyright © 2018年 yuka. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var box: UIView!
    
    var motionManager:CMMotionManager = CMMotionManager()
    var timer:Timer? = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        box.center = view.center
        
        // 0.1秒ごとに更新する設定
        motionManager.deviceMotionUpdateInterval = 0.1
        // 更新のスタート
        startUpdates()
        
        // 5秒後に更新をやめる
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { (action) in

            if self.motionManager.isDeviceMotionAvailable { // モーションの機能が使えるかチェック

                self.motionManager.stopDeviceMotionUpdates()
            }

        })
        
    }
    
    // 更新のスタート
    func startUpdates() {
        if motionManager.isDeviceMotionAvailable { // モーションの機能が使えるかチェック
            
            // 0.1秒ごとにwithHandlerが発動
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (motion, error) in
                    let motionX = motion?.gravity.x  // gravity が重力 userAccelerationが動かした加速度
                    let motionY = motion?.gravity.y
                    let boxX = Double(self.box.center.x)
                    let boxY = Double(self.box.center.y)      

                    self.box.center = CGPoint(x: motionX! * 100 + boxX, y: -motionY! * 100 + boxY)
                print(motionX,motionY)
            })
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

