//
//  BaseView.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/7/23.
//

import Foundation

@objc protocol BaseView {
    func startLoading()
    func finishLoading()
    func showErrorView(title: String,message: String)
    @objc optional func showSessionTimeout(title: String,message: String)
}
