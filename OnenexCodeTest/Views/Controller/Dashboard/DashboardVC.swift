//
//  DashboardVC.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/5/23.
//

import UIKit

class DashboardVC: BaseVC {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var userNameLbl: UILabel!
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
    
    private let presenter = DashboardPresenter(apiManager: APIManager())
    
    private var newsLetterData : [ArticlesCategoriesDataObjc] = []
    private var announceData : [ArticlesCategoriesDataObjc] = []
    private var promotionData : [ArticlesData] = []
    
    private var userInfoData : UserInfoData? {
        didSet {
            addUserInfoData()
        }
    }
    
    var timer : Timer?
    var currentIndex : Int = 0
    let tableCellRowHeight : CGFloat = 55
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(view: self)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetUp()
    }
    
    private func fetchData () {
        presenter.getUserInfoData()
        presenter.getPromotionsData()
        presenter.getAnnouncementsData()
        presenter.getNewsLetterData()
    }
    
    private func addUserInfoData () {
        self.userNameLbl.text = userInfoData?.name ?? "-"
    }
    
    private func initialUISetUp () {
        mainScrollView.showsVerticalScrollIndicator = false
        foldInBtn.isHidden = true
        foldOutBtn.isHidden = false
        lowerFeatureBtnContainerView.isHidden = true
        featureBtnsContainerView.constant = featureBtnsContainerView.constant - 95
        searchContainerView.layer.cornerRadius = 20
        buttonActionSetUp ()
        collectionViewInitialSetUp()
        tableViewInitialSetUp()
        
        // Page Control Initial Setup
        slidePageControl.currentPage = 0
        slidePageControl.numberOfPages = sliderProductsImages.count
        slidePageControl.addTarget(self, action: #selector(slidePageControlGotTapped), for: .valueChanged)
    }

    
    // MARK: - Table View Registration and Initial Set Up
    private func tableViewInitialSetUp () {
        // Table View Registration
        announcementTableView.register(UINib(nibName: "AnnouncementTableCell", bundle: nil), forCellReuseIdentifier: "announcement_cell")
        
        // Delegate and Datasource
        announcementTableView.rowHeight = tableCellRowHeight
        announcementTableView.delegate = self
        announcementTableView.dataSource = self
        announcementTableView.isScrollEnabled = false

    }
    
    // MARK: - CollectionView Registration and Initial Set Up
    private func collectionViewInitialSetUp () {
        // Collection View Registration
        pagingSliderCollectionView.register(UINib(nibName: "ImageSliderCollectionCell", bundle: nil), forCellWithReuseIdentifier: "imageslider_cell")
        promotionCollectionView.register(UINib(nibName: "PromotionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "promotions_cell")
        newsLetterCollectionView.register(UINib(nibName: "NewsLetterCollectionCell", bundle: nil), forCellWithReuseIdentifier: "newsletter_cell")
        
        // Delegate and Datasource
        pagingSliderCollectionView.dataSource = self
        pagingSliderCollectionView.delegate = self
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        newsLetterCollectionView.dataSource = self
        newsLetterCollectionView.delegate = self
        pagingSliderCollectionView.isPagingEnabled = true
    }
    
    // MARK: - Buttons Action Set Up
    private func buttonActionSetUp () {
        foldInBtn.addTarget(self, action: #selector(foldInButtonGotPressed), for: .touchUpInside)
        foldOutBtn.addTarget(self, action: #selector(foldOutButtonGotPressed), for: .touchUpInside)
    }
    
    // MARK: - Set Timer To Slide Images Automatically in Slider Collection View
    
//    private func setTimer () {
//        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextSlide), userInfo: nil, repeats: true)
//    }
//    
//    @objc func moveToNextSlide () {
//        DispatchQueue.main.async {
//            if self.currentIndex < self.sliderProductsImages.count - 1 {
//                self.currentIndex += 1
//            }else {
//                self.currentIndex = 0
//            }
//            self.pagingSliderCollectionView.layoutIfNeeded()
//            self.pagingSliderCollectionView.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true)
//        }
//    }
    
    
    // MARK: - Interactions

    @objc func slidePageControlGotTapped () {
        let newIndex = slidePageControl.currentPage
        let newOffset = CGPoint(x: CGFloat(newIndex) * pagingSliderCollectionView.frame.width, y: 0)
        pagingSliderCollectionView.setContentOffset(newOffset, animated: true)
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
            return sliderProductsImages.count
        }else if collectionView == promotionCollectionView {
            return promotionData.count
        }else {
            return newsLetterData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pagingSliderCollectionView {
            let cell = pagingSliderCollectionView.dequeueReusableCell(withReuseIdentifier: "imageslider_cell", for: indexPath) as! ImageSliderCollectionCell
            cell.images = UIImage(named: sliderProductsImages[indexPath.row])
            return cell
        }else if collectionView == promotionCollectionView {
            let cell = promotionCollectionView.dequeueReusableCell(withReuseIdentifier: "promotions_cell", for: indexPath) as! PromotionCollectionCell
            cell.promotionData = self.promotionData[indexPath.row]
            return cell
        }else {
            let cell = newsLetterCollectionView.dequeueReusableCell(withReuseIdentifier: "newsletter_cell", for: indexPath) as! NewsLetterCollectionCell
            cell.newsLetterData = self.newsLetterData[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pagingSliderCollectionView {
            return CGSize(width: pagingSliderCollectionView.frame.width, height: pagingSliderCollectionView.frame.height)
        }else if collectionView == promotionCollectionView{
            return CGSize(width: 200, height: 210)
        }else {
            return CGSize(width: 190, height: 280)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
            slidePageControl.currentPage = currentIndex
        }
}


extension DashboardVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementTableView.dequeueReusableCell(withIdentifier: "announcement_cell", for: indexPath) as! AnnouncementTableCell
        cell.announceData = self.announceData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension DashboardVC : DashboardView {
    
    func showPromotionsData(promotionData: [ArticlesData]) {
        self.promotionData = promotionData
        promotionCollectionView.reloadData()
    }
    
    func showAnnouncementData(announceData: [ArticlesCategoriesDataObjc]) {
        self.announceData = announceData
        announceTableViewHeightConstraint.constant = tableCellRowHeight * CGFloat(self.announceData.count) // Calculate TableView's Height Dynamically
        announcementTableView.reloadData()
    }
    
    func showNewsLetterData(newsLetterData: [ArticlesCategoriesDataObjc]) {
        self.newsLetterData = newsLetterData
        newsLetterCollectionView.reloadData()
    }
    
    func showUserInfoData(infoData: UserInfoData) {
        self.userInfoData = infoData
    }
    
    func startLoading() {
        self.showProgressDialog()
    }
    
    func finishLoading() {
        self.hideProgressDialog()
    }
    
    func showErrorView(title: String, message: String) {
        self.showAlertController(title, withMessage: message)
    }
}
