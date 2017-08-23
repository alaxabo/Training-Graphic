//
//  BackGroundView.swift
//  Flo
//
//  Created by Alaxabo on 8/23/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

@IBDesignable

class BackGroundView: UIView {

    @IBInspectable var lightColor: UIColor = UIColor.orange
    @IBInspectable var darkColor: UIColor = UIColor.yellow
    @IBInspectable var patternSize: CGFloat = 200
    
    
//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(darkColor.cgColor)
        context!.fill(rect)
        
        //Triang
        let drawSize = CGSize(width: patternSize, height: patternSize)
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        darkColor.setFill()
        drawingContext!.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        let triangPath = UIBezierPath()
        //1
        triangPath.move(to: CGPoint(x: drawSize.width/2,
                                    y: 0))
        //2
        triangPath.addLine(to: CGPoint(x: 0,
                                       y: drawSize.height/2))
        //3
        triangPath.addLine(to: CGPoint(x: drawSize.width,
                                       y: drawSize.height/2))
        //4
        triangPath.move(to: CGPoint(x: 0,
                                    y: drawSize.height/2))
        //5
        triangPath.addLine(to: CGPoint(x: drawSize.width/2,
                                       y: drawSize.height))
        //6
        triangPath.addLine(to: CGPoint(x: 0,
                                       y: drawSize.height))
        
        //7
        triangPath.move(to: CGPoint(x: drawSize.width,
                                    y: drawSize.height/2))
        //8
        triangPath.addLine(to: CGPoint(x: drawSize.width/2,
                                       y: drawSize.height))
        //9
        triangPath.addLine(to: CGPoint(x: drawSize.width,
                                       y: drawSize.height))
        
        lightColor.setFill()
        triangPath.fill()
     
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image!).setFill()
        context!.fill(rect)
    }
    

}
