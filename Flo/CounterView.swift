//
//  CounterView.swift
//  Flo
//
//  Created by Alaxabo on 8/11/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π: CGFloat = CGFloat(M_PI)

@IBDesignable
class CounterView: UIView {

    @IBInspectable var counter: Int = 5{
        didSet{
            if counter <= NoOfGlasses{
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width
            ,bounds.height)
        let arcWidth: CGFloat = 76
        
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Outline
        let angleDifference: CGFloat = 2 * π  - startAngle + endAngle
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
        let outLineEndAngle =  arcLengthPerGlass  * CGFloat(counter) + startAngle
        var outLinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outLineEndAngle,
                                       clockwise: true)
        outLinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - arcWidth + 2.5,
                           startAngle: outLineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        outLinePath.close()
        outlineColor.setStroke()
        outLinePath.lineWidth = 5
        outLinePath.stroke()
        
        //Counter View Marker
        let context = UIGraphicsGetCurrentContext()
        
        context!.saveGState()
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        var markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2,
                                                   y: 0,
                                                   width: markerWidth,
                                                   height: markerSize))
        
        context!.translateBy(x: rect.width/2,
                             y: rect.height/2)
        
        for i in 1 ... NoOfGlasses {
            context!.saveGState()
            var angle = arcLengthPerGlass * CGFloat(i) + startAngle - π / 2
            
            context!.rotate(by: angle)
            context!.translateBy(x: 0,
                                 y: rect.height/2 - markerSize)
            
            markerPath.fill()
            context!.restoreGState()
        }
        context!.restoreGState()
        
    }
    

}
