//
//  PushButtonView.swift
//  Flo
//
//  Created by Alaxabo on 8/11/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

@IBDesignable
class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.green
    @IBInspectable var isAddButton: Bool = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        var path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        let plusHeigth: CGFloat = 3.0
        let plusWidth: CGFloat = min (bounds.width, bounds.height) * 0.6
        
        //Create Path
        var plusPath = UIBezierPath()
        plusPath.lineWidth = plusHeigth
        
        plusPath.move(to: CGPoint(x: bounds.width/2 - plusWidth/2, y: bounds.height/2))
        
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + plusWidth/2, y: bounds.height/2))
        
        
        //Vertical Line
        if isAddButton
        {
        plusPath.move(to: CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 - plusWidth/2 + 0.5))
        plusPath.addLine(to: CGPoint(x: bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))
        }
        UIColor.white.setStroke()
        plusPath.stroke()
    }

}
