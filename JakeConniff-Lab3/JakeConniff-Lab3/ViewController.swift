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
//        circleCanvas.theCircle = nil
//        circleCanvas.circles = []
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
//    var circleCanvas: CircleView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        circleCanvas = CircleView(frame: view.frame)
//        view.addSubview(circleCanvas)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        switch currentMode{
        case .Draw:
            switch currentShape {
            case .Square:
                currentSquare = Square(origin: touchPoint, color: currentColor, length: 0)
            case .Circle:
                break
            case .Triangle:
                break
            }
        case .Move:
            break
        case .Erase:
            break
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: view) as CGPoint
        
        switch currentMode {
        case .Draw:
            switch currentShape {
            case .Square:
                let distance = Functions.distance(a: touchPoint, b: (currentSquare?.origin)!)
                currentSquare?.length = distance * 2
                drawingView.setNeedsDisplay()
            case .Circle:
                break
            case .Triangle:
                break
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
            switch currentShape {
            case .Square:
                if let newSquare = currentSquare {
                    drawingView.items.append(newSquare)
                }
            case .Circle:
                break
            case .Triangle:
                break
            }
        case .Move:
            break
        case .Erase:
            break
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

