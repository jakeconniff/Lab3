//
//  ViewController.swift
//  JakeConniff-Lab3
//
//  Created by Sproull Student on 10/5/22.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var drawingView: DrawingView!
    @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
    @IBOutlet var rotateGesture: UIRotationGestureRecognizer!
    
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var shapeSegment: UISegmentedControl!
    @IBOutlet weak var modeSegment: UISegmentedControl!
    
    @IBAction func savePhoto(_ sender: Any) {
        let rend = UIGraphicsImageRenderer(size: drawingView.bounds.size)
        let photo = rend.image {
            ctx in drawingView.drawHierarchy(in: drawingView.bounds, afterScreenUpdates: true)
        }
        UIImageWriteToSavedPhotosAlbum(photo,nil,nil,nil)
    }
    
    @IBAction func clearDrawings(_ sender: Any) {
        drawingView.items = []
    }
    enum ThisShape{
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
    var currentShape = ThisShape.Square
    var currentColor = UIColor.systemRed
    
    var currentRadius :CGFloat = 0
    var currentCircle: Circle?
    var currentSquare: Square?
    var currentTriangle: Triangle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawingView.addGestureRecognizer(pinchGesture)
        drawingView.addGestureRecognizer(rotateGesture)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1 else { return }
        let touchPoint = (touches.first)!.location(in: drawingView) as CGPoint
        switch currentMode{
        case .Draw:
            switch currentShape {
            case .Square:
                currentSquare = Square(type: "Square", origin: touchPoint, color: currentColor.withAlphaComponent(CGFloat(alphaSlider.value)), scale: 50)
                guard currentSquare != nil else{return}
                drawingView.items.append(currentSquare!)
            case .Circle:
                currentCircle = Circle(type: "Circle", origin: touchPoint, color: currentColor.withAlphaComponent(CGFloat(alphaSlider.value)), scale: 50)
                guard currentCircle != nil else{return}
                drawingView.items.append(currentCircle!)
            case .Triangle:
                currentTriangle = Triangle(type: "Triangle", origin: touchPoint, color: currentColor.withAlphaComponent(CGFloat(alphaSlider.value)), scale: 50)
                guard currentTriangle != nil else{return}
                drawingView.items.append(currentTriangle!)
            }
        case .Move:
            if let index = drawingView.items.firstIndex(where:{$0.contains(point: touchPoint)}){
                let current : Shape = drawingView.items[index] as! Shape
                switch current.type{
                case "Square":
                    currentSquare = (current as! Square)
                    currentShape = .Square
                    drawingView.items.remove(at: index)
                    guard currentSquare != nil else {return}
                    drawingView.items.append(currentSquare!)
                case "Circle":
                    currentCircle = (current as! Circle)
                    currentShape = .Circle
                case "Triangle":
                    currentTriangle = (current as! Triangle)
                    currentShape = .Triangle
                default:
                    break
                }
            }
        case .Erase:
            if let index = drawingView.items.firstIndex(where: {$0.contains(point: touchPoint)}){
                drawingView.items.remove(at:index)
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: drawingView) as  CGPoint
        
        switch currentMode {
        case .Draw:
            break
        case .Move:
            //draw recognize delete redraw
            switch currentShape{
            case .Square:
                currentSquare?.origin = touchPoint
                guard currentSquare != nil else {return}
                drawingView.items.remove(at: drawingView.items.count-1)
                drawingView.items.append(currentSquare!)
            case .Circle:
                currentCircle?.origin = touchPoint
                guard currentCircle != nil else {return}
                drawingView.items.remove(at: drawingView.items.count-1)
                drawingView.items.append(currentCircle!)
            case .Triangle:
                currentTriangle?.origin = touchPoint
                guard currentTriangle != nil else {return}
                drawingView.items.remove(at: drawingView.items.count-1)
                drawingView.items.append(currentTriangle!)
            }
        case .Erase:
            break
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch currentMode {
        case .Draw:
            break
        case .Move:
            currentSquare = nil
            currentCircle = nil
            currentTriangle = nil
        case .Erase:
            break
        }
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
            currentSquare = nil
            currentCircle = nil
            currentTriangle = nil
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
    UIGestureRecognizer) -> Bool {
    true }
    
    @IBAction func pinchActivated(_ sender: UIPinchGestureRecognizer) {
        switch currentMode{
        case .Draw:
            break
        case .Move:
            if let index = drawingView.items.firstIndex(where:{$0.contains(point: sender.location(in:drawingView))}){
                //it's definitely pinching
                let current : Shape = drawingView.items[index] as! Shape
                switch current.type{
                case "Square":
                    currentSquare = (current as! Square)
                    if sender.state.rawValue == 1{
                        currentRadius = currentSquare!.scaleFactor
                    }
                    currentSquare?.scaleFactor = currentRadius * sender.scale
                    drawingView.items.remove(at: index)
                    drawingView.items.append(currentSquare!)
                case "Circle":
                    currentCircle = (current as! Circle)
                    if sender.state.rawValue == 1{
                        currentRadius = currentCircle!.scaleFactor
                    }
                    currentCircle?.scaleFactor = currentRadius * sender.scale
                    drawingView.items.remove(at: index)
                    drawingView.items.append(currentCircle!)
                case "Triangle":
                    currentTriangle = (current as! Triangle)
                    if sender.state.rawValue == 1{
                        currentRadius = currentTriangle!.scaleFactor
                    }
                    currentTriangle?.scaleFactor = currentRadius * sender.scale
                    drawingView.items.remove(at: index)
                    drawingView.items.append(currentTriangle!)
                default:
                    break
                }
                print(sender.state.rawValue)
            }
        case .Erase:
            break
        }
    }
    
    @IBAction func rotateActivated(_ sender: UIRotationGestureRecognizer) {
        switch currentMode{
        case .Draw:
            break
        case .Move:
            if let index = drawingView.items.firstIndex(where:{$0.contains(point: sender.location(in:drawingView))}){
                //it's definitely pinching
                let current : Shape = drawingView.items[index] as! Shape
                switch current.type{
                case "Square":
                    currentSquare = (current as! Square)
                    if sender.state.rawValue == 1{
                        currentRadius = currentSquare!.scaleFactor
                    }
                    currentSquare?.rotation = sender.rotation
                    drawingView.items.remove(at: index)
                    drawingView.items.append(currentSquare!)
                case "Circle":
                    currentCircle = (current as! Circle)
                    if sender.state.rawValue == 1{
                        currentRadius = currentCircle!.scaleFactor
                    }
                    currentCircle?.rotation = sender.rotation
                    drawingView.items.remove(at: index)
                    drawingView.items.append(currentCircle!)
                case "Triangle":
                    currentTriangle = (current as! Triangle)
                    if sender.state.rawValue == 1{
                        currentRadius = currentTriangle!.scaleFactor
                    }
                    currentTriangle?.rotation = sender.rotation
                    drawingView.items.remove(at: index)
                    drawingView.items.append(currentTriangle!)
                default:
                    break
                }
                print(sender.state.rawValue)
            }
        case .Erase:
            break
        }
    }    
}
