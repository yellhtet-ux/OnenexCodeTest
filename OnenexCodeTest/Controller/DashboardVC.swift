//
//  DashboardVC.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/5/23.
//

import UIKit

class DashboardVC: UIViewController {
    
    
    @IBOutlet var announceTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var newsLetterCollectionView: UICollectionView!
    @IBOutlet var announcementTableView: UITableView!
    @IBOutlet var promotionCollectionView: UICollectionView!
    @IBOutlet var sliderPageControl: UIPageControl!
    @IBOutlet var pagingSliderCollectionView: UICollectionView!
    @IBOutlet var featureBtnContainerView: UIView!
    @IBOutlet var foldInBtn: UIButton!
    @IBOutlet var foldOutBtn: UIButton!
    @IBOutlet var cardView: CardView!
    @IBOutlet var searchContainerView: UIView!
    
    private let sliderProductsImages : [UIImage] = [UIImage(named: "home_slide_img")!,UIImage(named: "home_slide_img")!,UIImage(named: "home_slide_img")!]
    
    var timer : Timer?
    var currentIndex : Int = 0
    let tableCellRowHeight : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    private func UISetUp () {
        containerViewInitialSetUp ()
        buttonActionSetUp ()
        collectionViewInitialSetUp()
        tableViewInitialSetUp()
        setTimer()
        sliderPageControl.currentPage = 0
        sliderPageControl.numberOfPages = sliderProductsImages.count
    }
    
    private func containerViewInitialSetUp () {
        searchContainerView.layer.cornerRadius = 20
        foldInBtn.layer.cornerRadius = 8
        foldOutBtn.layer.cornerRadius = 8
        foldOutBtn.isHidden = true
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
        pagingSliderCollectionView.register(UINib(nibName: "ImageSliderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "imageSlider_Cell")
        promotionCollectionView.register(UINib(nibName: "PromotionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "promotion_cell")
        newsLetterCollectionView.register(UINib(nibName: "NewsLetterCollectionCell", bundle: nil), forCellWithReuseIdentifier: "newsletter_cell")
        
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
        if currentIndex < sliderProductsImages.count - 1{
            let index = IndexPath(item: currentIndex, section: 0)
            pagingSliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            currentIndex += 1
        }else {
            currentIndex = 0
        }
        
        sliderPageControl.currentPage = currentIndex
    }
    
    private func buttonActionSetUp () {
        foldInBtn.addTarget(self, action: #selector(foldInButtonGotPressed), for: .touchUpInside)
        foldOutBtn.addTarget(self, action: #selector(foldOutButtonGotPressed), for: .touchUpInside)
    }
    
    @objc func foldInButtonGotPressed () {
        featureBtnContainerView.isHidden = true
        foldOutBtn.isHidden = false
    }
    
    @objc func foldOutButtonGotPressed () {
        featureBtnContainerView.isHidden = false
        foldOutBtn.isHidden = true
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
            let cell = pagingSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "imageSlider_Cell", for: indexPath) as! ImageSliderCollectionCell
            cell.slideImg.image = sliderProductsImages[indexPath.row]
            return cell
        }else if collectionView == promotionCollectionView {
            let cell = pagingSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "promotion_cell", for: indexPath) as! PromotionCollectionCell
            return cell
        }else {
            let cell = newsLetterCollectionView.dequeueReusableCell(withReuseIdentifier: "newsletter_cell", for: indexPath) as! NewsLetterCollectionCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pagingSliderCollectionView {
//            return CGSize(width: pagingSliderCollectionView.frame.width, height: pagingSliderCollectionView.frame.height)
            return CGSize(width: 100, height: 100)
        }else if collectionView == promotionCollectionView{
            return CGSize(width: 200, height: 190)
        }else {
            return CGSize(width: 190, height: 280)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
