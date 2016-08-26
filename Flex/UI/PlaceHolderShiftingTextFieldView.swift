//
//  PlaceHolderShiftingTextField.swift
//  UnderLinedTextField
//
//  Created by Varinda Hart on 8/5/16.
//  Copyright © 2016 ShopKeep. All rights reserved.
//

import UIKit

class PlaceHolderShiftingTextFieldView: UIView {

    var textLabel = UILabel()
    var textField = UITextField()
    var midToLeftLayer = CAShapeLayer()
    var midToRightLayer = CAShapeLayer()
    var underlineBar = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Label"
        addSubview(textLabel)
        addSubview(textField)
        self.textField.delegate = self
        layoutElements()
        styleTextField()
        styleLabel()
        setUpLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func layoutElements() {
        var allConstraints = [NSLayoutConstraint]()
        let views = ["textLabel": textLabel, "textField": textField]
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[textLabel(\(frame.height * 0.4))]-4-[textField(\(frame.height * 0.6))]-0-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[textLabel]", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[textField]-0-|", options: [], metrics: nil, views: views)

        NSLayoutConstraint.activateConstraints(allConstraints)
    }
    
    func styleTextField() {
        textField.font = .systemFontOfSize(20)
        textField.placeholder = "Enter Text"
        layoutIfNeeded()
    }
    
    func styleLabel() {
        textLabel.text = "Enter Text"
        textLabel.alpha = 0
        textLabel.textColor = .grayColor()
    }
    
    func setUpLayers() {
        let startingPoint = CGPoint(x: frame.width / 2, y: 0)
        let leftPoint = CGPoint(x: 0, y: 0)
        let rightPoint = CGPoint(x: frame.width, y: 0)
        
        let leftRect = CGRect(origin: CGPoint(x: 0, y: frame.height),
            size: CGSize(width: frame.width / 2, height: 2))
        
        let rightRect = CGRect(origin: CGPoint(x: 0, y: frame.height),
            size: CGSize(width: frame.width / 2, height: 2))
        
        let pathToLeft = UIBezierPath()
        pathToLeft.moveToPoint(startingPoint)
        pathToLeft.addLineToPoint(leftPoint)
        
        let pathToRight = UIBezierPath()
        pathToRight.moveToPoint(startingPoint)
        pathToRight.addLineToPoint(rightPoint)
        
        let tintColor = textField.tintColor
        
        midToLeftLayer.frame = leftRect
        midToLeftLayer.path = pathToLeft.CGPath
        midToLeftLayer.strokeColor = tintColor.CGColor
        midToLeftLayer.strokeEnd = 0
        midToLeftLayer.fillColor = nil
        midToLeftLayer.geometryFlipped = true
        midToLeftLayer.lineWidth = 2.0
        
        midToRightLayer.frame = rightRect
        midToRightLayer.path = pathToRight.CGPath
        midToRightLayer.strokeColor = tintColor.CGColor
        midToRightLayer.strokeEnd = 0
        midToRightLayer.fillColor = nil
        midToRightLayer.geometryFlipped = true
        midToRightLayer.lineWidth = 2.0

        let underlineRect = CGRect(origin: CGPoint(x: 0, y: frame.height),
            size: CGSize(width: frame.width, height: 2))
        let underline = UIBezierPath()
        underline.moveToPoint(leftPoint)
        underline.addLineToPoint(rightPoint)
        underlineBar.frame = underlineRect
        underlineBar.path = underline.CGPath
        underlineBar.strokeColor = UIColor.grayColor().CGColor
        underlineBar.opacity = 0.7
        underlineBar.strokeEnd = 1
        underlineBar.fillColor = nil
        underlineBar.geometryFlipped = true
        underlineBar.lineWidth = 1.0
        
        layer.addSublayer(underlineBar)
        layer.addSublayer(midToLeftLayer)
        layer.addSublayer(midToRightLayer)
    
    }
}

extension PlaceHolderShiftingTextFieldView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        animateUnderlineLayer()
        return true
    }
    
    func animateUnderlineLayer() {
        underlineBar.opacity = 0
        midToRightLayer.strokeEnd = 1
        midToLeftLayer.strokeEnd = 1
        textField.placeholder = nil
        UIView.animateWithDuration(0.3) {
            self.textLabel.alpha = 1
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        endEditing(true)
        midToLeftLayer.strokeEnd = 0
        midToRightLayer.strokeEnd = 0
        let shouldFadeInTextField = textField.text == nil || textField.text == ""
        if shouldFadeInTextField {
            self.textField.alpha = 0
            self.textField.placeholder = "Enter Text"
        }
        UIView.animateWithDuration(0.3) {
            self.textField.alpha = 1
            self.textLabel.alpha = 0
            }
        underlineBar.opacity = 0.7
        
        return true
    }
}

