//
//  ViewController.swift
//  CADisPlayLink
//
//  Created by Zhang on 2017/3/3.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var displayLink:CADisplayLink!
    var displayTime:Int = 0
    
    var imageView = UIView()
    var loadImageView = UIImageView()
    
    var headerView:BaiduApp!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = BaiduApp.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 200))
        headerView.backgroundColor = UIColor.red
        headerView.baiduWaveClouse = { (current) in
        }
        headerView.startWaveAnimation()
        self.view.addSubview(headerView)
//        self.imageView.frame = CGRect.init(x: self.view.center.x - 14, y: 30, width: 28, height: 28)
//        self.imageView.backgroundColor = UIColor.red;
//        self.loadImageView.frame = CGRect.init(x: self.view.center.x - 14, y: 30, width: 28, height: 28)
//        loadImageView.image = UIImage.init(named: "加载动画圆点")
//        self.view.addSubview(self.imageView)
//        self.view.addSubview(self.loadImageView)
//        
//        self.displayLink = CADisplayLink.init(target: self, selector: #selector(ViewController.displayLinkeAction))
//        self.displayLink.frameInterval = 60
//        self.displayLink.isPaused = false
//        self.displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
//    func displayLinkeAction(){
//        print(displayTime)
//        displayTime = displayTime + 1
//        let ani = CAKeyframeAnimation(keyPath: "transform.rotation.z")
//        ani.keyTimes = [0,0.48,1]
//        ani.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.014,-0.003,0.726,0.306), CAMediaTimingFunction(controlPoints: 0.233,0.824,0.326,0.97)]
//        ani.values = [0,3.543,6.283]
//        ani.duration = 1
//        self.loadImageView.layer.add(ani, forKey: "animation")
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

