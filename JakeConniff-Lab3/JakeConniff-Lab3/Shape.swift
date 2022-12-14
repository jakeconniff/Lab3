//
//  Shape.swift
//  CSE 438S Lab 3
//
//  Created by Michael Ginn on 5/31/21.
//

import UIKit

/**
 YOU SHOULD MODIFY THIS FILE.
 
 Feel free to implement it however you want, adding properties, methods, etc. Your different shapes might be subclasses of this class, or you could store information in this class about which type of shape it is. Remember that you are partially graded based on object-oriented design. You may ask TAs for an assessment of your implementation.
 */

/// A `DrawingItem` that draws some shape to the screen.
class Shape: DrawingItem {
    var type : String
    var path : UIBezierPath
    var origin : CGPoint
    var color : UIColor
    var scaleFactor : CGFloat
    var rotation : CGFloat = 0
    required init(type: String, origin: CGPoint, color: UIColor, scale: CGFloat){
        self.path = UIBezierPath()
        self.type = type
        self.origin = origin
        self.color = color
        self.scaleFactor = scale
    }
    required init(origin: CGPoint, color: UIColor) {
        fatalError("init(origin:color:) has not been implemented")
    }
    
    func draw() {
        fatalError("IMPLEMENT THIS")
    }
    
    func contains(point: CGPoint) -> Bool {
        fatalError("IMPLEMENT THIS")
    }
}
