//
//  BaiduApp.swift
//  CADisPlayLink
//
//  Created by Zhang on 2017/3/3.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

typealias BaiduWaveClouse = (_ currentY:CGFloat) -> Void

class BaiduApp: UIView {

    var waveCuvature:CGFloat!
    var waveSpeed:CGFloat!
    var waveHeight:CGFloat!
    var realWaveColor:UIColor!
    var maskWaveColor:UIColor!
    
    var baiduWaveClouse:BaiduWaveClouse!
    
    var realWaveLayer:CAShapeLayer!
    var maskWaveLayer:CAShapeLayer!
    
    var displayLinke:CADisplayLink!
    
    var offset:CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(){
        self.waveSpeed = 0.5
        self.waveHeight = 4
        self.waveCuvature = 1.5
        self.realWaveColor = UIColor.white
        self.maskWaveColor = UIColor.init(white: 1, alpha: 0.4)
        
        self.setUpView()

        
        self.layer.addSublayer(self.realWaveLayer)
        self.layer.addSublayer(self.maskWaveLayer)
    }
    
    func setUpView(){
        self.realWaveLayer = CAShapeLayer.init()
        var frame = self.bounds
        frame.origin.y = frame.size.height - self.waveHeight
        frame.size.height = self.waveHeight
        self.realWaveLayer.frame = frame
        self.realWaveLayer.fillColor = self.realWaveColor.cgColor
        
        var frame1 = self.bounds
        self.maskWaveLayer = CAShapeLayer.init()
        frame1.origin.y = frame1.size.height - self.waveHeight
        frame1.size.height = self.waveHeight
        self.maskWaveLayer.frame = frame1
        self.maskWaveLayer.fillColor = self.maskWaveColor.cgColor
    }
    
    
    func setWaveHeight(waveHeight:CGFloat) {
        self.waveHeight = waveHeight
        
        var frame = self.bounds
        frame.origin.y = frame.size.height - self.waveHeight
        frame.size.height = self.waveHeight
        self.realWaveLayer.frame = frame
        
        var frame1 = self.bounds
        frame1.origin.y = frame1.size.height - self.waveHeight
        frame1.size.height = self.waveHeight
        self.maskWaveLayer.frame = frame1
    }
    
    func stopWaveAnimation(){
        self.displayLinke.invalidate()
        self.displayLinke = nil
    }
    
    func startWaveAnimation(){
        let proxy = BaiduProxy.init()
        proxy.executor = self
        self.displayLinke = CADisplayLink.init(target: proxy, selector: #selector(proxy.callback))
        self.displayLinke.add(to: .current, forMode: .commonModes)
    }
    
    func wave(){
        self.offset = self.offset + self.waveSpeed
        
        let width:CGFloat = self.bounds.size.width
        let height = self.waveHeight
        
        let path = CGMutablePath()
        path.move(to: CGPoint.init(x: 0, y: height!), transform: CGAffineTransform.init())
        var y:CGFloat = 0
        
        let maskpath = CGMutablePath()
        maskpath.move(to: CGPoint.init(x: 0, y: height!), transform: CGAffineTransform.init())
        var maskY:CGFloat = 0
        for index in 0...Int(width) {
            y = CGFloat(height!) * CGFloat(sinf(Float(0.01 * self.waveCuvature * CGFloat(index)) + Float(self.offset * 0.045)))
            path.addLine(to: CGPoint.init(x: CGFloat(index), y: y))
            maskY = -y
            maskpath.addLine(to: CGPoint.init(x: CGFloat(index), y: maskY))
        }
        
        let centX = self.bounds.size.width / 2
        let centY = CGFloat(height!) * CGFloat(sinf(Float(0.01 * self.waveCuvature * centX) + Float(self.offset * 0.045)))
        if ((self.baiduWaveClouse) != nil) {
            self.baiduWaveClouse(centY);
        }
        
        path.addLine(to: CGPoint.init(x: width, y: height!))
        path.addLine(to: CGPoint.init(x: 0, y: height!))
        path.closeSubpath()

        self.realWaveLayer.path = path;
        self.realWaveLayer.fillColor = self.realWaveColor.cgColor;
        
        maskpath.addLine(to: CGPoint.init(x: width, y: height!))
        maskpath.addLine(to: CGPoint.init(x: 0, y: height!))
        path.closeSubpath()
        
        self.maskWaveLayer.path = maskpath;
        self.maskWaveLayer.fillColor = self.maskWaveColor.cgColor;
    }

}

class BaiduProxy : NSObject {
    var executor:UIView!
    
    func callback(){
        executor.perform(#selector(BaiduApp.wave))
    }
}
