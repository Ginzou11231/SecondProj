//
//  CustomTabbar.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/23.
//

import UIKit

class CustomTabbar: UITabBar {
    
    private var sharpLayer : CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addPath()
    }
    
    func addPath(){
        let sharpLayer = CAShapeLayer()
        sharpLayer.path = createPath()
        sharpLayer.strokeColor = UIColor.black.cgColor
        sharpLayer.fillColor = UIColor.systemBlue.cgColor
        sharpLayer.lineWidth = 1.0
        
        sharpLayer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        sharpLayer.shadowOffset = CGSize(width: 0, height: -1)
        sharpLayer.shadowOpacity = 0.5
        
        if let oldLayer = self.sharpLayer{
            self.layer.replaceSublayer(oldLayer, with: sharpLayer)
        }else{
            self.layer.insertSublayer(sharpLayer, at: 0)
        }
        
        self.sharpLayer = sharpLayer
    }
    
    func createPath() -> CGPath{
        
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.minX + 35, y: 10))
        path.addQuadCurve(to:CGPoint(x: self.frame.minX + 40, y: 15) , controlPoint: CGPoint(x: self.frame.minX + 40, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.minX + 40, y: 25))
        path.addQuadCurve(to:CGPoint(x: self.frame.minX + 45, y: 30) , controlPoint: CGPoint(x: self.frame.minX + 40, y: 30))
        
        path.addLine(to: CGPoint(x: self.frame.minX + 95, y: 30))
        path.addQuadCurve(to:CGPoint(x: self.frame.minX + 100, y: 25) , controlPoint: CGPoint(x: self.frame.minX + 100, y: 30))
        
        path.addLine(to: CGPoint(x: self.frame.minX + 100, y: 15))
        path.addQuadCurve(to:CGPoint(x: self.frame.minX + 105, y: 10) , controlPoint: CGPoint(x: self.frame.minX + 100, y: 10))
        
        path.addLine(to: CGPoint(x: centerWidth - 35, y: 10))
        path.addQuadCurve(to:CGPoint(x: centerWidth - 30, y: 15) , controlPoint: CGPoint(x: centerWidth - 30, y: 10))
        
        path.addLine(to: CGPoint(x: centerWidth - 30, y: 25))
        path.addQuadCurve(to:CGPoint(x: centerWidth - 25, y: 30) , controlPoint: CGPoint(x: centerWidth - 30, y: 30))
        
        path.addLine(to: CGPoint(x: centerWidth + 25, y: 30))
        path.addQuadCurve(to:CGPoint(x: centerWidth + 30, y: 25) , controlPoint: CGPoint(x: centerWidth + 30, y: 30))
        
        path.addLine(to: CGPoint(x: centerWidth + 30, y: 15))
        path.addQuadCurve(to:CGPoint(x: centerWidth + 35, y: 10) , controlPoint: CGPoint(x: centerWidth + 30, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.maxX - 105, y: 10))
        path.addQuadCurve(to:CGPoint(x: self.frame.maxX - 100, y: 15) , controlPoint: CGPoint(x: self.frame.maxX - 100, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.maxX - 100, y: 25))
        path.addQuadCurve(to:CGPoint(x: self.frame.maxX - 95, y: 30) , controlPoint: CGPoint(x: self.frame.maxX - 100, y: 30))
        
        path.addLine(to: CGPoint(x: self.frame.maxX - 45, y: 30))
        path.addQuadCurve(to:CGPoint(x: self.frame.maxX - 40, y: 25) , controlPoint: CGPoint(x: self.frame.maxX - 40, y: 30))
        
        path.addLine(to: CGPoint(x: self.frame.maxX - 40, y: 15))
        path.addQuadCurve(to:CGPoint(x: self.frame.maxX - 35, y: 10) , controlPoint: CGPoint(x: self.frame.maxX - 40, y: 10))
        
        path.addLine(to: CGPoint(x: self.frame.maxX, y: 10))
        path.addLine(to: CGPoint(x: self.frame.maxX, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
}
