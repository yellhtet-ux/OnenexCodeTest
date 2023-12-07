//
//  DashboardVC.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/5/23.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet var featureBtnsContainerView: NSLayoutConstraint!
    @IBOutlet var lowerFeatureBtnContainerView: UIView!
    @IBOutlet var announceTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var newsLetterCollectionView: UICollectionView!
    @IBOutlet var announcementTableView: UITableView!
    @IBOutlet var promotionCollectionView: UICollectionView!
    @IBOutlet var slidePageControl : UIPageControl!
    @IBOutlet var pagingSliderCollectionView: UICollectionView!
    @IBOutlet var foldInBtn: UIButton!
    @IBOutlet var foldOutBtn: UIButton!
    @IBOutlet var cardView: CardView!
    @IBOutlet var searchContainerView: UIView!
    
    private let sliderProductsImages : [String] = ["home_slide_img","home_slide_img","home_slide_img"]
    
    var timer : Timer?
    var currentIndex : Int = 0
    let tableCellRowHeight : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    private func UISetUp () {
        foldInBtn.isHidden = true
        foldOutBtn.isHidden = false
        lowerFeatureBtnContainerView.isHidden = true
        featureBtnsContainerView.constant = featureBtnsContainerView.constant - 95
        containerViewInitialSetUp ()
        buttonActionSetUp ()
        collectionViewInitialSetUp()
        tableViewInitialSetUp()
        setTimer()
        slidePageControl.currentPage = 0
        slidePageControl.numberOfPages = sliderProductsImages.count
    }
    
    private func containerViewInitialSetUp () {
        searchContainerView.layer.cornerRadius = 20
    }
    
    // MARK: - Table View Registration and Initial Set Up
    private func tableViewInitialSetUp () {
        announcementTableView.register(UINib(nibName: "AnnouncementTableCell", bundle: nil), forCellReuseIdentifier: "announcement_cell")
        announcementTableView.rowHeight = tableCellRowHeight
        announcementTableView.delegate = self
        announcementTableView.dataSource = self
        announcementTableView.isScrollEnabled = false
        announceTableViewHeightConstraint.constant = tableCellRowHeight * 3
    }
    
    
    // MARK: - CollectionView Registration and Initial Set Up
    private func collectionViewInitialSetUp () {
        pagingSliderCollectionView.register(UINib(nibName: "ImageSliderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "imageslider_cell")
        newsLetterCollectionView.register(UINib(nibName: "NewsLetterCollectionCell", bundle: nil), forCellWithReuseIdentifier: "newsletter_cell")
        promotionCollectionView.register(UINib(nibName: "PromotionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "promotion_cell")
        pagingSliderCollectionView.dataSource = self
        pagingSliderCollectionView.delegate = self
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        newsLetterCollectionView.dataSource = self
        newsLetterCollectionView.delegate = self
        pagingSliderCollectionView.isPagingEnabled = true
    }
    
    private func setTimer () {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextSlide), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextSlide () {
        DispatchQueue.main.async {
            if self.currentIndex < self.sliderProductsImages.count - 1 {
                self.currentIndex += 1
            }else {
                self.currentIndex = 0
            }
            self.pagingSliderCollectionView.layoutIfNeeded()
            if let layout = self.pagingSliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let contentOffset = layout.collectionViewContentSize.width / CGFloat(self.sliderProductsImages.count) * CGFloat(self.currentIndex)
                        self.pagingSliderCollectionView.setContentOffset(CGPoint(x: contentOffset, y: 0), animated: true)
                    }
//            self.pagingSliderCollectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            
        }
    }
    
/*
 if let layout = self.pagingSliderCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
     let contentOffset = layout.collectionViewContentSize.width / CGFloat(self.sliderProductsImages.count) * CGFloat(self.currentIndex)
             self.pagingSliderCollectionView.setContentOffset(CGPoint(x: contentOffset, y: 0), animated: true)
         }
 
 
 guard let currentIndexPath = self.pagingSliderCollectionView.indexPathsForVisibleItems.first else {
           return
       }
       var nextItem = (currentIndexPath.item + 1) % self.sliderProductsImages.count
       let nextIndexPath = IndexPath(item: nextItem, section: 0)

 */

    
    private func buttonActionSetUp () {
        foldInBtn.addTarget(self, action: #selector(foldInButtonGotPressed), for: .touchUpInside)
        foldOutBtn.addTarget(self, action: #selector(foldOutButtonGotPressed), for: .touchUpInside)
    }
    
    @objc func foldInButtonGotPressed () {
        UIView.animate(withDuration: 0.5) {
            self.lowerFeatureBtnContainerView.isHidden = true
            self.foldInBtn.isHidden = true
            self.foldOutBtn.isHidden = false
            self.featureBtnsContainerView.constant = self.featureBtnsContainerView.constant - 95
        }
    }
    
    @objc func foldOutButtonGotPressed () {
        UIView.animate(withDuration: 0.5) {
            self.lowerFeatureBtnContainerView.isHidden = false
            self.foldOutBtn.isHidden = true
            self.foldInBtn.isHidden = false
            self.featureBtnsContainerView.constant = 220.0
        }
    }
}


extension DashboardVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pagingSliderCollectionView {
            return sliderProductsImages.count // For Image Slider Collection View
        }else if collectionView == promotionCollectionView {
            return 3 // For Promotion Collection View
        }else {
            return 3 // For NewsLetter Collection View
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pagingSliderCollectionView {
            let cell = pagingSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "imageslider_cell", for: indexPath) as! ImageSliderCollectionCell
            cell.images = UIImage(named: sliderProductsImages[indexPath.item])
            return cell
        }else if collectionView == promotionCollectionView {
            let cell = promotionCollectionView.dequeueReusableCell(withReuseIdentifier: "promotion_cell", for: indexPath) as! PromotionCollectionCell
            return cell
        }else {
            let cell = newsLetterCollectionView.dequeueReusableCell(withReuseIdentifier: "newsletter_cell", for: indexPath) as! NewsLetterCollectionCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pagingSliderCollectionView {
            return CGSize(width: pagingSliderCollectionView.frame.width, height: pagingSliderCollectionView.frame.height)
        }else if collectionView == promotionCollectionView{
            return CGSize(width: 200, height: 190)
        }else {
            return CGSize(width: 190, height: 280)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round( scrollView.contentOffset.x / scrollView.frame.size.width)
        slidePageControl.currentPage = Int(currentPage)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == scrollView.contentSize.width - scrollView.frame.size.width {
            // User scrolled to the last page, reset to the first page
            scrollView.contentOffset.x = 0
            slidePageControl.currentPage = 0
        }
    }
}


extension DashboardVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementTableView.dequeueReusableCell(withIdentifier: "announcement_cell", for: indexPath) as! AnnouncementTableCell
        return cell
    }
    
}
