//
//  ScanCodeViewController.swift
//  Lottery
//
//  Created by GuestUserLogin on 01/10/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import UIKit
import AVFoundation

enum ScanCodeResult {
    case success(TiketDetails), invaliddata
}
protocol ScanCodeResultDelegate {
    func scanCodeResult(result: ScanCodeResult)
}

class ScanCodeViewController: UIViewController {
    var delegate: ScanCodeResultDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanCode()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.reader.isRunning {
            self.reader.stopScanning()
        }
    }
    
    func scanCode() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            guard self.checkScanPermissions(), !self.reader.isRunning else { return }
            
            self.reader.didFindCode = { result in
                self.barCodeResult(value: result.value)
            }
            
            self.reader.startScanning()
        }
    }
    
    
    @IBOutlet weak var previewView: QRCodeReaderView! {
        didSet {
            previewView.setupComponents(with: QRCodeReaderViewControllerBuilder {
                $0.reader                 = reader
                $0.showTorchButton        = false
                $0.showSwitchCameraButton = false
                $0.showCancelButton       = false
                $0.showOverlayView        = true
                $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            })
        }
    }
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr, .ean13, .ean8, .pdf417, .code128, .code93, .code39], captureDevicePosition: .back)
            $0.showTorchButton         = false
            $0.preferredStatusBarStyle = .lightContent
            $0.showOverlayView         = true
            $0.rectOfInterest          = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // MARK: - Actions
    
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch _  {
            let alert: UIAlertController
            alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    func barCodeResult(value: String) {
         let barcodeData = value.components(separatedBy: ",")
        self.dismiss(animated: true) {
            if barcodeData.count == 4 {
                let ticketDetails = TiketDetails(bookletSeries: barcodeData[0], bookletNumber: barcodeData[1], ticketNumber: barcodeData[1], lotId: barcodeData[3])
                self.delegate?.scanCodeResult(result: .success(ticketDetails))
            }else {
                self.delegate?.scanCodeResult(result: .invaliddata)
            }
        }
    }
}
