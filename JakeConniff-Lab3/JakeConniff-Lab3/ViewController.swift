//
//  ViewController.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var drawingView: DrawingView!
    
    @IBOutlet weak var shapeSegment: UISegmentedControl!
    @IBOutlet weak var modeSegment: UISegmentedControl!
    
    @IBAction func clearDrawings(_ sender: Any) {
        drawingView.items = []
    }
    enum DrawShape{
        case Square
        case Circle
        case Triangle
    }
    enum Mode{
        case Draw
        case Move
        case Erase
    }
    var currentMode = Mode.Draw
    var currentShape = DrawShape.Square
    var currentColor = UIColor.systemRed
    
    var currentCircle: Circle?
    var currentSquare: Square?
    var currentTriangle: Triangle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touchPoint = (touches.first)!.location(in: drawingView) as CGPoint
        switch currentMode{
        case .Draw:
            switch currentShape {
            case .Square:
                currentSquare = Square(origin: touchPoint, color: currentColor, scale: 20)
                drawingView.items.append(currentSquare!)
            case .Circle:
                currentCircle = Circle(origin: touchPoint, color: currentColor, scale: 20)
                drawingView.items.append(currentCircle!)
            case .Triangle:
                currentTriangle = Triangle(origin: touchPoint, color: currentColor, scale: 20)
                drawingView.items.append(currentTriangle!)
            }
        case .Move:
            break
        case .Erase:
            break
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: drawingView) as CGPoint
        
        switch currentMode {
        case .Draw:
            switch currentShape {
            case .Square:
                let distance = Functions.distance(a: touchPoint, b: (currentSquare?.origin)!)
                print("Distance \(distance)")
                currentSquare?.scaleFactor = distance * 2
                
                if let newSquare = currentSquare {
                    print("Drawn length \(newSquare.scaleFactor)")
                    drawingView.items.removeLast()
                    drawingView.items.append(newSquare)
                }
            case .Circle:
                let distance = Functions.distance(a: touchPoint, b: (currentCircle?.origin)!)
                currentCircle?.scaleFactor = distance
                
                if let newCircle = currentCircle {
                    
                    drawingView.items.removeLast()
                    drawingView.items.append(newCircle)
                }
            case .Triangle:
                let distance = Functions.distance(a: touchPoint, b: (currentTriangle?.origin)!)
                currentTriangle?.scaleFactor = distance
                
                if let newTriangle = currentTriangle {
                    
                    drawingView.items.removeLast()
                    drawingView.items.append(newTriangle)
                }
            }
        case .Move:
            break
        case .Erase:
            break
        }
        //currentCircle?.radius = distance
        //circleCanvas.theCircle = currentCircle

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch currentMode {
        case .Draw:
            break
        case .Move:
            break
        case .Erase:
            switch currentShape{
            case .Square:
                break
            case .Circle:
                break
            case .Triangle:
                break
            }
        }
//        if let newCircle = currentCircle {
//            circleCanvas.circles.append(newCircle)
//        }s

    }
    
    //switching color to draw with
    @IBAction func switchRed(_ sender: Any) {
        currentColor = UIColor.systemRed
    }
    @IBAction func switchGreen(_ sender: Any) {
        currentColor = UIColor.systemGreen
    }
    @IBAction func switchBlue(_ sender: Any) {
        currentColor = UIColor.systemBlue
    }
    @IBAction func switchYellow(_ sender: Any) {
        currentColor = UIColor.systemYellow
    }
    @IBAction func switchBlack(_ sender: Any) {
        currentColor = UIColor.black
    }
    
    //switching action mode
    @IBAction func modeChanged(_ sender: Any) {
        switch modeSegment.selectedSegmentIndex{
        case 0:
            currentMode = .Draw
        case 1:
            currentMode = .Move
        case 2:
            currentMode = .Erase
        default:
            break
        }
    }

    //switching the shape to draw
    @IBAction func shapeChanged(_ sender: Any) {
        switch shapeSegment.selectedSegmentIndex{
        case 0:
            currentShape = .Square
        case 1:
            currentShape = .Circle
        case 2:
            currentShape = .Triangle
        default:
            break
        }
    }
    
}

