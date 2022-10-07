//
//  Triangle.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class Triangle: Shape{
    public required init(type: String, origin: CGPoint, color: UIColor, scale: CGFloat){
        super.init(type: type, origin: origin, color: color, scale: scale)
    }
    
    //ignore
    required init(origin: CGPoint, color: UIColor) {
        fatalError("init(origin:color:) has not been implemented")
    }
    
    override func draw(){
        self.path.removeAllPoints()
        self.color.setFill()
        //ogx, ogy-height
        self.path.move(to: CGPoint(x: self.origin.x, y: self.origin.y-Functions.triHeight(x: self.scaleFactor)))
        //ogx+sidefactor, ogy+
        self.path.addLine(to: CGPoint(x: self.origin.x+self.scaleFactor, y: self.origin.y-Functions.triHeight(x: self.scaleFactor)))
        self.path.addLine(to: CGPoint(x: self.origin.x, y: self.origin.y + Functions.triHeight(x: self.scaleFactor)))
        self.path.addLine(to: CGPoint(x:self.origin.x-self.scaleFactor, y: self.origin.y-Functions.triHeight(x: self.scaleFactor)))
        self.path.rotate(by: self.rotation)
        self.path.fill()
        self.path.close()
    }
}
