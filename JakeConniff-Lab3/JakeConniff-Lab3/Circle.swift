//
//  Circle.swift
//  InClassDemo1
//
//  Created by Todd Sproull on 6/16/20.
//  Copyright © 2020 Todd Sproull. All rights reserved.
//

import UIKit

class Circle: Shape {
    required init(type: String, origin: CGPoint, color: UIColor, scale: CGFloat){
        super.init(type: type, origin: origin, color: color, scale: scale)
    }
    
    required init(origin: CGPoint, color: UIColor) {
        fatalError("init(origin:color:) has not been implemented")
    }
    
    override func draw(){
        self.color.setFill()
        
        self.path.addArc(withCenter: self.origin, radius: self.scaleFactor , startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        self.path.rotate(by: self.rotation)
        self.path.fill()
        self.path.close()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
}
