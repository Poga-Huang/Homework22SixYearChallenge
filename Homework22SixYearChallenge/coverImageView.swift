//
//  coverImageView.swift
//  Homework22SixYearChallenge
//
//  Created by 黃柏嘉 on 2021/11/25.
//

import UIKit

class coverImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height*0.7))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.close()
        
        let imageLayer = CAShapeLayer()
        imageLayer.path = path.cgPath
        layer.mask = imageLayer
        }
}
