//
//  scalingBezier.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/6/22.
//
import UIKit

extension UIBezierPath {
    //unused
    func scaleAroundCenter(factor: CGFloat) {
        let beforeCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)

        let scaleTransform = CGAffineTransform(scaleX: factor, y: factor)
        self.apply(scaleTransform)

        let afterCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let diff = CGPoint( x: beforeCenter.x - afterCenter.x, y: beforeCenter.y - afterCenter.y)

        let translateTransform = CGAffineTransform(translationX: diff.x, y: diff.y)
        self.apply(translateTransform)
    }
    
    func rotate(by angleRadians: CGFloat){
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: angleRadians)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        self.apply(transform)
    }

}
