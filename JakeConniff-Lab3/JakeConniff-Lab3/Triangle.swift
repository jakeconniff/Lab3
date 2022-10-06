//
//  Triangle.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class Triangle: Shape{
    public required init(origin: CGPoint, color: UIColor, scale: CGFloat){
        super.init(origin: origin, color: color, scale: scale)
    }
    
    //ignore
    required init(origin: CGPoint, color: UIColor) {
        fatalError("init(origin:color:) has not been implemented")
    }
    
    override func draw(){
        self.color.setFill()
        self.path.move(to: CGPoint(x: self.origin.x, y: self.origin.y-Functions.triHeight(x: self.scaleFactor)))
        self.path.addLine(to: CGPoint(x: self.origin.x+self.scaleFactor, y: self.origin.y-Functions.triHeight(x: self.scaleFactor)))
        self.path.addLine(to: CGPoint(x: self.origin.x, y: self.origin.y + Functions.triHeight(x: self.scaleFactor)))
        self.path.addLine(to: CGPoint(x:self.origin.x-Functions.triHeight(x: self.scaleFactor), y: self.origin.y-Functions.triHeight(x: self.scaleFactor)))
        self.path.close()
        self.path.fill()
    }
}
