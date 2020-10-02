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
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var mobileWarningLabel: UILabel!
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
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
        self.loginApiResult(result: .success(LoginEntityModel(error: false, data: nil)))
        return
        let validationResult = presenter?.inputs.signInTapped(userName: mobileNumberTf.text, password: passwordTf.text)
        switch  validationResult {
        case .success:
            self.startIndicator(indicator: indicator)
            self.presenter?.loginApi(using: mobileNumberTf.text!, password: passwordTf.text!)
        case .failure(let field):
            switch field {
            case .mobileNumber:
                self.mobileWarningLabel.isHidden = false
                self.mobileNumberView.borderColour = .red
            case .password:
                self.passwordWarningLabel.isHidden = false
                self.passwordView.borderColour = .red
            }
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.mobileWarningLabel.isHidden = true
        self.passwordWarningLabel.isHidden = true
        self.mobileNumberView.borderColour = .lightGray
        self.passwordView.borderColour = .lightGray
        if textField.text?.count == 10, string.isEmpty {
            return true
        }
        return textField.text?.count != 10
    }
    
}

extension LoginViewController: LoginPresenterToViewProtocol {
    func loginApiResult(result: Result<LoginEntityModel>) {
        self.stopIndicator(indicator: indicator)
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                if response.error == false {
                    self.showTicketScreen()
                } else {
                    self.showOkayAlert(title: "Error", message: "Login Failed, Please try againe.")
                }
            case .failure(let error):
                if let errorIs = error as? apiHandlerErrors {
                    self.showOkayAlert(title: "Error", message: errorIs.description)
                } else {
                    self.showOkayAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func showTicketScreen() {
        guard let soldTicketVC = CommonUtils.ticketStoryboard.instantiateViewController(identifier: "SoldTicketViewController") as? SoldTicketViewController else{
            preconditionFailure("Unable to get LoginViewController")
        }
        self.navigationController?.pushViewController(soldTicketVC, animated: true)
    }
    
}
