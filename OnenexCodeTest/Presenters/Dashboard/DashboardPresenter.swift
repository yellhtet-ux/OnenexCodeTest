//
//  DashboardPresenter.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/6/23.
//

import Foundation

 protocol DashboardView : BaseView {
     // Fetch Datas from presenter and send to View
     func showUserInfoData(infoData: UserInfoData)
     func showPromotionsData (promotionData:  [ArticlesData])
     func showAnnouncementData (announceData: [ArticlesCategoriesDataObjc])
     func showNewsLetterData(newsLetterData: [ArticlesCategoriesDataObjc])
}

class DashboardPresenter : BasePresenter {
    private let apiManager: APIManager
    private var view: DashboardView?
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func attachView(view: DashboardView){
        self.view = view
    }
    
    func detachView() {
      view = nil
    }
    
    
    func showError(_ message: String) {
      if message.lowercased().contains("expired") {
        self.view?.showSessionTimeout?(title: "", message: message)
      } else {
          self.view?.showErrorView(title: "", message: message)
      }
    }
    
    // Get Default User Info Data
    func getUserInfoData () {
        let request = LoginRequest(email: "superadmin@onenex.co", password: "password") // Default User
        self.view?.startLoading()
        var userEndPoint = UserEndPoint.login(request: request)
        apiManager.postData(userEndPoint)
            .subscribe(
              onNext: { [weak self](response: LoginResponse) in
                  self?.view?.finishLoading()
                  
                  if let user_token = response.data?.access_token {
                      // Save User Token in Keychain to use other additional purposes!
                      KeychainManager.shared.saveKChainValueString(user_token, HelperKeys.USER_TOKEN)
                  }
                  if let infoData = response.data?.user {
                      self?.view?.showUserInfoData(infoData: infoData)
                  }
              },
              onError: { (err) in
                self.view?.finishLoading()
                  let errMsg = err.localizedDescription
                  self.view?.showErrorView(title: "Error", message: errMsg)
              }
            )
            .disposed(by: disposeBag)
    }
    
    // Get Promotion Datas
    func getPromotionsData () {
        self.view?.startLoading()
        let promotionEndPoint = DashboardEndPoint.promotions
        apiManager.getData(promotionEndPoint)
                .subscribe(
                  onNext: { [weak self](response: PromotionResponse) in
                      self?.view?.finishLoading()
                      if let promotionData = response.data {
                          let articlesArray: [ArticlesData] = [
                              promotionData.twentySeven,promotionData.twentyEight,promotionData.twentyNine,promotionData.thirty,promotionData.thirtyOne,promotionData.thirtyTwo,promotionData.thirtyThree,promotionData.thirtyFour,promotionData.thirtyFive,promotionData.eighteen,promotionData.nineteen,promotionData.twenty,promotionData.twentyOne,promotionData.twentyTwo,promotionData.twentyThree,promotionData.twentyFour,promotionData.twentyFive,promotionData.twentySix,promotionData.nine,promotionData.ten,promotionData.eleven,promotionData.twelve,promotionData.thirteen,promotionData.fourteen,promotionData.fifteen,promotionData.sixteen,promotionData.seventeen,promotionData.zero,promotionData.one,promotionData.two,promotionData.three,promotionData.four,promotionData.five,promotionData.six,promotionData.seven,promotionData.eight
                          ].compactMap { $0 }
                          self?.view?.showPromotionsData(promotionData: articlesArray)
                      }
                  },
                  onError: { (err) in
                    self.view?.finishLoading()
                      let errMsg = err.localizedDescription
                      self.view?.showErrorView(title: "Error", message: errMsg)
                  }
                )
                .disposed(by: disposeBag)
    }
    
    // Get Announcement Datas
    func getAnnouncementsData () {
        self.view?.startLoading()
        let announcementEndPoint = DashboardEndPoint.announcements
        apiManager.getData(announcementEndPoint)
                .subscribe(
                  onNext: { [weak self](response: AnnounceAndNewsLetterResponse) in
                    self?.view?.finishLoading()
                      if let announceResponseData = response.data {
                          let announcementData : [ArticlesCategoriesDataObjc] = [
                            announceResponseData.one,announceResponseData.two,announceResponseData.three,announceResponseData.four,announceResponseData.five,announceResponseData.six,announceResponseData.seven,announceResponseData.eight,announceResponseData.nine,announceResponseData.ten,announceResponseData.eleven
                          ].compactMap {$0}
                          self?.view?.showAnnouncementData(announceData: announcementData)
                      }
                  },
                  onError: { (err) in
                    self.view?.finishLoading()
                      let errMsg = err.localizedDescription
                      self.view?.showErrorView(title: "Error", message: errMsg)
                  }
                )
                .disposed(by: disposeBag)
    }
    
    // Get Newsletter Datas
    func getNewsLetterData () {
        self.view?.startLoading()
        let newsLetterEndPoint = DashboardEndPoint.newsletters
        apiManager.getData(newsLetterEndPoint)
                .subscribe(
                  onNext: { [weak self](response: AnnounceAndNewsLetterResponse) in
                    self?.view?.finishLoading()
                      if let newsLetterResponseData = response.data {
                          let newsLetterData : [ArticlesCategoriesDataObjc] = [
                            newsLetterResponseData.one,newsLetterResponseData.two,newsLetterResponseData.three,newsLetterResponseData.four,newsLetterResponseData.five,newsLetterResponseData.six,newsLetterResponseData.seven,newsLetterResponseData.eight,newsLetterResponseData.nine,newsLetterResponseData.ten,newsLetterResponseData.eleven
                          ].compactMap {$0}
                          self?.view?.showNewsLetterData(newsLetterData: newsLetterData)
                      }
                  },
                  onError: { (err) in
                    self.view?.finishLoading()
                      let errMsg = err.localizedDescription
                      self.view?.showErrorView(title: "Error", message: errMsg)
                  }
                )
                .disposed(by: disposeBag)
    }
    
}
