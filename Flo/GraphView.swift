//
//  GraphView.swift
//  Flo
//
//  Created by Alaxabo on 8/11/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    
    var graphPoints: [Int] = [4 ,2 ,6 ,4 ,5 ,8 ,3]
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let width = rect.width
        let height = rect.height
        
        var path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: UIRectCorner.allCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        context?.drawLinearGradient(gradient!,
                                    start: startPoint,
                                    end: endPoint,
                                    options: CGGradientDrawingOptions(rawValue: 0))
        
        let margin: CGFloat = 20.0
        var columnXPoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1 ))
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.max()
        var columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        var graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0),
                                   y: columnYPoint(graphPoints[0])))
        
        for i in  1 ..< graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i),
                                    y: columnYPoint(graphPoints[i]))
            graphPath.addLine(to: nextPoint)
        }
        context?.saveGState()

//        let clippingPath = graphPath.copy() as! UIBezierPath
//        
//        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1),
//                                         y: height))
//        clippingPath.addLine(to: CGPoint(x: columnXPoint(0),
//                                         y: height))
//        clippingPath.close()
//        clippingPath.addClip()
        
//        let highestYPoint = columnYPoint(maxValue!)
//        startPoint = CGPoint(x: margin, y: highestYPoint)
//        endPoint = CGPoint(x: margin, y: self.bounds.height)
//        
//        context!.drawLinearGradient(gradient!,
//                                    start: startPoint,
//                                    end: endPoint,
//                                    options: CGGradientDrawingOptions(rawValue: 0))
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        for i in 0 ..< graphPoints.count{
            var point = CGPoint(x: columnXPoint(i),
                                y: columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point,
                                                     size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        var linePath = UIBezierPath()
        
        //top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin,
                                     y: topBorder))
        //center line
        linePath.move(to: CGPoint(x: margin,
                                  y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin,
                                     y: graphHeight/2 + topBorder))
        //bottom line
        linePath.move(to: CGPoint(x: margin,
                                  y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin,
                                     y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
        }
}

