//
//  ViewController.swift
//  Flo
//
//  Created by Alaxabo on 8/11/17.
//  Copyright © 2017 Alaxabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterView: CounterView!
    
    @IBOutlet weak var averageWaterDrunk: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPushButton(button: PushButtonView){
        if button.isAddButton {
            if counterView.counter < 8{
            counterView.counter += 1
            }
        }
        else{
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
    counterLabel.text = String(counterView.counter)
        if isGraphViewShowing{
            counterViewTap(gesture: nil)
        }
    }
    
    @IBAction func counterViewTap(gesture: UITapGestureRecognizer?){
        let transitionLeftOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        let transitionRightOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        if (isGraphViewShowing){
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: transitionLeftOptions,
                              completion: nil)
        }
        else{
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: transitionRightOptions,
                              completion: nil)
            setUpGraphDisplay()

        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setUpGraphDisplay(){
        let noOfDay: Int = 7
        
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        
        graphView.setNeedsDisplay()
        let maxDrunk = graphView.graphPoints.max()
        maxLabel.text = String(maxDrunk!)
        
        let average = graphView.graphPoints.reduce(0, +)
            / graphView.graphPoints.count
        averageWaterDrunk.text = "\(average)"
        
//        let dateFormatter = DateFormatter()
//        let calendar = Calendar.current
//        let componentOptions: Calendar.Component = .weekday
//        let components = calendar.component(componentOptions, from: NSDate() as Date)
        
        var weekday = Date().dayNumberOfWeek()
        let days = ["S","S","M","T","W","T","F"]
        
        for i in 1 ... days.count {
            if let labelView = graphView.viewWithTag(i) as? UILabel {
                if weekday == 7 {
                    weekday = 0
                }
                labelView.text = days[weekday!]
                weekday! = weekday! - 1
                if weekday! < 0 {
                    weekday! = days.count - 1
                }
            }
        }
        
    }

}
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

