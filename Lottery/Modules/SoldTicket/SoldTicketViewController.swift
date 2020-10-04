//
//  SoldTicketViewController.swift
//  Lottery
//
//  Created by GuestUserLogin on 30/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import UIKit

class SoldTicketViewController: UIViewController {
    var presenter: SoldTicketPresenter?
    @IBOutlet weak var bookletSeriesTF: UITextField!
    @IBOutlet weak var bookletNumberTF: UITextField!
    @IBOutlet weak var ticketNumberTF: UITextField!
    @IBOutlet weak var lotIdTf: UITextField!
    var indicator = ActivityIndicatorService()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.clearBorderColour()
    }
    
    func initView() {
        let leftTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        leftTitleLabel.text = "Create Sold Ticket"
        leftTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        leftTitleLabel.textColor = .white
        leftTitleLabel.textAlignment = .left
        let leftBarButton = UIBarButtonItem.init(customView: leftTitleLabel)
        navigationItem.leftBarButtonItem = leftBarButton
        
        
        self.bookletSeriesTF.layer.borderColor = UIColor.red.cgColor
        self.bookletNumberTF.layer.borderColor = UIColor.red.cgColor
        self.ticketNumberTF.layer.borderColor = UIColor.red.cgColor
        self.lotIdTf.layer.borderColor = UIColor.red.cgColor
    }
    
    @IBAction func scanAction(_ sender: Any) {
        self.clearBorderColour()
        if let vc = CommonUtils.ticketStoryboard.instantiateViewController(identifier: "ScanCodeViewController") as? ScanCodeViewController {
            vc.delegate = self
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let ticketDetails = TiketDetails(bookletSeries: bookletSeriesTF.text ?? "", bookletNumber: bookletNumberTF.text ?? "", ticketNumber: ticketNumberTF.text ?? "", lotId: lotIdTf.text ?? "")
        let validationResult = presenter?.validateTicketData(details: ticketDetails)
        switch validationResult {
        case .success:
            self.startLoadingIndicator(indicator: indicator)
            self.presenter?.submitTicketDetailsApi(details: ticketDetails)
        case .failure(let failureField):
            switch failureField {
            case .bookletSeries:
                self.bookletSeriesTF.layer.borderWidth = 1.0
            case .bookletNumber:
                self.bookletNumberTF.layer.borderWidth = 1.0
            case .ticketNumber:
                self.ticketNumberTF.layer.borderWidth = 1.0
            case .lotId:
                self.lotIdTf.layer.borderWidth = 1.0
            }
        case .none:
            break
        }
    }
    
    @IBAction func dashboardAction(_ sender: Any) {
        self.showDashBoardScreen()
    }
    
    private func clearBorderColour() {
        self.bookletSeriesTF.layer.borderWidth = 0.0
        self.bookletNumberTF.layer.borderWidth = 0.0
        self.ticketNumberTF.layer.borderWidth = 0.0
        self.lotIdTf.layer.borderWidth = 0.0
    }
    private func clearFields() {
        self.bookletSeriesTF.text = ""
        self.bookletNumberTF.text = ""
        self.ticketNumberTF.text = ""
        self.lotIdTf.text = ""
    }
    
    
    func showDashBoardScreen() {
        if let vc = CommonUtils.ticketStoryboard.instantiateViewController(identifier: "DashboardViewController") as? DashboardViewController {
            vc.urlString = Constants.UrlManager.dashBoardApi(with: CommonUtils.userName ?? "", password: CommonUtils.password ?? "")
            let navigationVC = UINavigationController(rootViewController: vc)
            navigationVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationVC, animated: true, completion: nil)
        }
    }
    
}

extension SoldTicketViewController : ScanCodeResultDelegate {
    func scanCodeResult(result: ScanCodeResult) {
        switch result {
        case .success(let ticketDetails):
            self.bookletSeriesTF.text = ticketDetails.bookletSeries
            self.bookletNumberTF.text = ticketDetails.bookletNumber
            self.ticketNumberTF.text = ticketDetails.ticketNumber
            self.lotIdTf.text = ticketDetails.lotId
        default:
            self.showOkayAlert(title: "Alert", message: "Invalid data, Please scan correct code.")
        }
    }
    
    func submitDetailsResult(result: Result<[String: Any]>) {
        self.stopLoadingIndicator(indicator: indicator)
        DispatchQueue.main.async {
            switch result {
            case .success(let responseDict):
                if let error = responseDict["error"] as? Bool, error {
                    self.showOkayAlert(title: "Error", message: responseDict["error_msg"] as? String ?? Constants.AlertMessages.inValidaRequests)
                } else {
                    self.clearFields()
                    self.showOkayAlert(title: "Success", message: responseDict["msg"] as? String ?? "Successfully submitted ticket details.")
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
    
    
}
