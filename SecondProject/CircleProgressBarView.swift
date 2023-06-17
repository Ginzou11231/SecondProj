//
//  CircleProgressBar.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/16.
//

import UIKit

class CircleProgressBarView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
    var bgView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCircularPath(){
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 150, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 35.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1)
        
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 25.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = CGColor(red: 1, green: 1, blue: 127/255 , alpha: 1)
        
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        progressLayer.removeAllAnimations()
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    func progressStop(){
        progressLayer.removeAllAnimations()
    }
}
