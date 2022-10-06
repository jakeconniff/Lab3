//
//  CircleView.swift
//  InClassDemo1
//
//  Created by Todd Sproull on 6/16/20.
//  Copyright © 2020 Todd Sproull. All rights reserved.
//

import UIKit

class CircleView: UIView {

    var theCircle:Circle? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var circles: [Circle] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func drawCircle(_ circle: Circle) {
        
        UIColor.green.setFill()
        let path = UIBezierPath()
        
        path.addArc(withCenter: circle.center, radius: circle.radius    , startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        path.fill()
//  ----Black outline------
//        UIColor.black.setStroke()
//        path.stroke()
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        backgroundColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    
        for circle in circles {
            drawCircle(circle)
        }
        
        if (theCircle != nil){
            drawCircle(theCircle!)
        }

    }
    
}
