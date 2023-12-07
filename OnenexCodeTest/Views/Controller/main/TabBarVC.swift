//
//  TabBarVC.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/6/23.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    // MARK: - Create Highlight Selection View
    let selectionHighlightView: UIView = {
        let view = UIView()
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10)
        maskLayer.path = path.cgPath

        view.backgroundColor = UIColor(hex: "#20507A")
        view.layer.addSublayer(maskLayer)
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(hex: "#20507A")
        self.delegate = self
        
        tabBar.addSubview(selectionHighlightView)
        
        let tabBarHeight = tabBar.frame.size.height
        let highlightHeight: CGFloat = 4.0
        let highlightWidth = tabBar.frame.size.width / CGFloat(tabBar.items?.count ?? 1)
        selectionHighlightView.frame = CGRect(x: highlightWidth / 2.0 - highlightWidth / 4.0, y: 0, width: highlightWidth / 2.0, height: highlightHeight)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.selectedIndex
            let tabBarWidth = tabBar.frame.size.width
            let highlightWidth = tabBarWidth / CGFloat(tabBar.items?.count ?? 1)
            let newX = CGFloat(selectedIndex) * highlightWidth + highlightWidth / 2.0 - selectionHighlightView.frame.size.width / 2.0
            UIView.animate(withDuration: 0.3) {
                self.selectionHighlightView.frame.origin.x = newX
            }
       }
}
