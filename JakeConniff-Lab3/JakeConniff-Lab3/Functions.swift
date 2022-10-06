//
//  Functions.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class Functions {
    static func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt(pow(a.x-b.x, 2) + pow(a.y-b.y, 2))
    }
}
