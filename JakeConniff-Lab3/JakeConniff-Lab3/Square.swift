//
//  Square.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class Square: Shape {
    var length : CGFloat
    var path : UIBezierPath
    required init(origin: CGPoint, color: UIColor, length: CGFloat){
        self.length = length
        self.path = UIBezierPath()
        super.init(origin: origin, color: color)
    }
    
    required init(origin: CGPoint, color: UIColor) {
        fatalError("init(origin:color:) has not been implemented")
    }
    
    override func draw() {
        self.color.setFill()
        let start = CGPoint(x: self.origin.x + self.length/2, y: self.origin.y + self.length/2)
        self.path.move(to: start)
        self.path.addLine(to: CGPoint(x: start.x + self.length, y: start.y))
        self.path.addLine(to: CGPoint(x: start.x + self.length, y: start.y+self.length))
        self.path.addLine(to: CGPoint(x: start.x , y: start.y + self.length))
        self.path.close()
        self.path.fill()
    }
    
    override func contains(point: CGPoint) -> Bool {
        fatalError("IMPLEMENT THIS")
    }
}
