//
//  ViewController.swift
//  Lottery
//
//  Created by GuestUserLogin on 28/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mobileNumberView: APPCustomeView!
    @IBOutlet weak var passwordView: APPCustomeView!
    @IBOutlet weak var mobileNumberTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var keyboardAvoider: ScrollingKeyboardAvoidable!
    var presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        self.initView()
    }

    
    func initView() {
        self.addShadowToView(view: self.mobileNumberView, shadowRadious: 3.0)
        self.addShadowToView(view: self.passwordView, shadowRadious: 3.0)
        keyboardAvoider = PaddedKeyboardAvoider(scrollView: scrollView)
        hideKeyboardWhenTappedAround()
    }

    @IBAction func signInAction(_ sender: Any) {
        presenter?.inputs.signInTapped(userName: mobileNumberTf.text, password: passwordTf.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 10, string.isEmpty {
            return true
        }
        return textField.text?.count != 10
    }
    
}

extension LoginViewController: LoginPresenterToViewProtocol {
   
    
}
