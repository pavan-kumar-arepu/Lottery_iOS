//
//  CustomeView+IBDesignable.swift
//  Lottery
//
//  Created by GuestUserLogin on 29/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import Foundation
import Foundation
import UIKit

@IBDesignable
class APPCustomeView: UIView {
    @IBInspectable var cornerRadiusValue: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderColour: UIColor = .clear {
        didSet {
            setUpView()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColour.cgColor
        //self.clipsToBounds = true
    }
    
}

@IBDesignable
class APPCustomeButton: UIButton {
    @IBInspectable var cornerRadiusValue: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderColour: UIColor = .clear {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColour.cgColor
        self.clipsToBounds = true
    }
}

@IBDesignable
class AppCustomField: UITextField {
    @IBInspectable var cornerRadiusValue: CGFloat = 5.0 {
        didSet {
            setUpShadow()
        }
    }
    
    @IBInspectable var shadowColour: UIColor = .clear {
        didSet {
            setUpShadow()
        }
    }
    
    @IBInspectable var shadowRadious: CGFloat = 0.0 {
        didSet {
            setUpShadow()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setUpShadow()
        }
    }
    
    @IBInspectable var borderColour: UIColor = .clear {
        didSet {
            setUpShadow()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpShadow()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpShadow()
    }
   
    func setUpShadow() {
        self.layer.shadowColor = UIColor.whiteTwo.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadious
        self.layer.cornerRadius = self.cornerRadiusValue
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColour.cgColor
    }
}
