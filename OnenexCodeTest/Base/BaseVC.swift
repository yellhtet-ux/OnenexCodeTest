//
//  BaseVC.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import UIKit
import JGProgressHUD

// MARK: - Base VC for All View Controllers

class BaseVC : UIViewController {
    
    var progressDialog = JGProgressHUD()
    
    var progressView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressView()
    }
    
    // MARK: - Built In UIActivity Indicator View to Show when loading
    func setupProgressView() {
        progressView = UIActivityIndicatorView(style: .large)
        progressView.color = UIColor(hex: "#20507A")
        progressView.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        progressView.center = self.view.center

        let labelHeight: CGFloat = 20
        let progressLabel = UILabel(frame: CGRect(x: 0, y: progressView.bounds.height / 1.2, width: progressView.bounds.width, height: labelHeight))
        progressLabel.text = "Loading..."
        progressLabel.font = UIFont.systemFont(ofSize: 9)
        progressLabel.textColor = .black
        progressLabel.textAlignment = .center

        progressView.addSubview(progressLabel)

        view.addSubview(progressView)
    }
    
    func showProgressDialog() {
        if !progressDialog.isVisible {
            progressDialog = JGProgressHUD(style: .dark)
            progressDialog.textLabel.text = "Loading"
            progressDialog.show(in: self.view)
        }
    }
    
    func hideProgressDialog() {
        progressDialog.dismiss()
    }
    
    func showAlertController(_ title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
