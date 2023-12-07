//
//  BaseVC.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation
import UIKit
import JGProgressHUD

class BaseVC : UIViewController {
    
    var progressDialog = JGProgressHUD()
    
    var progressView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressView()
    }
    
    
    func setupProgressView() {
        // Initialize UIActivityIndicatorView
        progressView = UIActivityIndicatorView(style: .large)
        progressView.color = UIColor(hex: "#20507A")
        progressView.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        progressView.center = self.view.center

        // Initialize UILabel
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
//        progressView.startAnimating()
//        progressView.hidesWhenStopped = true
    }
    
    func hideProgressDialog() {
        
        progressDialog.dismiss()
        
//        progressView.stopAnimating()
//        if progressView.isAnimating {
//            self.progressView.isHidden = true
//        }
        
    }
}
