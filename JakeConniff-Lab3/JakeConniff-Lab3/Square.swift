//
//  Square.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class Square: Shape {
    required init(type: String, origin: CGPoint, color: UIColor, scale: CGFloat){
        super.init(type: type, origin: origin, color: color, scale: scale)
    }
    
    required init(origin: CGPoint, color: UIColor) {
        fatalError("init(origin:color:) has not been implemented")
    }
    
    override func draw() {
        self.path.removeAllPoints()
        self.color.setFill()
        let start = CGPoint(x: self.origin.x - self.scaleFactor/2, y: self.origin.y - self.scaleFactor/2)
        self.path.move(to: start)
        self.path.addLine(to: CGPoint(x: start.x + self.scaleFactor, y: start.y))
        self.path.addLine(to: CGPoint(x: start.x + self.scaleFactor, y: start.y+self.scaleFactor))
        self.path.addLine(to: CGPoint(x: start.x , y: start.y + self.scaleFactor))
        self.path.rotate(by: self.rotation)
        self.path.fill()
        self.path.close()
    }
    
    override func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
}
