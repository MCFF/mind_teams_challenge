//
//  Stepper.swift
//  MindTeamsChallenge
//
//  Created by Francisco Escobar on 20/10/21.
//

import Foundation
import UIKit

class UIFieldStepper: UITextField{
    
    var fieldStepperDelegate: UIFieldStepperDelegate?
    
    var max = 10
    var min = 0
    var steps = 1
    var defaultValue = 0{
        didSet{
            self.text = "\(defaultValue)"
        }
    }
    var value:Int{
        if let counterString = self.text, let counter = Int(counterString){
            return counter
        }
        return 0
    }
    
    var isEditable:Bool = true {
        didSet{
            if isEditable{
                setLeftView()
                setRightView()
                self.isUserInteractionEnabled = true
            }else{
                setLeftViewDisabled()
                setRightViewDisabled()
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        

        self.text = "\(defaultValue)"
        self.textAlignment = .center
        
        self.leftViewMode = .always
        self.rightViewMode = .always
        
        setLeftView()
        setRightView()
       
    }
    
    private func setLeftView(){
        let minusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(UIColor(named: "GrayMid"), for: .normal)
        minusButton.addTarget(self, action: #selector(substract), for: .touchUpInside)
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        leftView.addSubview(minusButton)
        
        self.leftView = leftView
    }
    
    private func setRightView(){
        
        let plusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(UIColor(named: "GrayMid"), for: .normal)
        plusButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        rightView.addSubview(plusButton)
        
        self.rightView = rightView
    }
    
    private func setLeftViewDisabled(){
       
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        
        self.leftView = leftView
    }
    
    private func setRightViewDisabled(){
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        
        self.rightView = rightView
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 50, height: self.frame.height)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: self.frame.width-50, y: 0, width: 50, height: self.frame.height)
    }
    
    @objc func add(){
        
        if let counterString = self.text, let counter = Int(counterString){
            if counter < max{
                self.text = "\(counter+steps)"
            }
        }else{
            self.text = "1"
        }
        
        fieldStepperDelegate?.valueDidChange(self)
    }
    
    @objc func substract(){
        
        if let counterString = self.text, let counter = Int(counterString){
            if counter > min{
                self.text = "\(counter-steps)"
            }
        }else{
            self.text = "0"
        }
        
        fieldStepperDelegate?.valueDidChange(self)
    }
    
}
