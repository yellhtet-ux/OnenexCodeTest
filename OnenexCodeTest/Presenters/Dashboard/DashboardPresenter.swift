//
//  DashboardPresenter.swift
//  OnenexCodeTest
//
//  Created by Andrew Hardin on 12/6/23.
//

import Foundation

 protocol DashboardView : BaseView {

}

class DashboardPresenter : BasePresenter {
    private let apiManager: APIManager
    private var view: DashboardView?
    var timer : Timer?
    
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
        self.view?.showErrorView?(title: "", message: message)
      }
    }
    
    func getPromotionsData () {
        self.view?.startLoading()
        var promotionEndPoint = DashboardEndPoint.promotions
        apiManager.getData(promotionEndPoint)
                .subscribe(
                  onNext: { [weak self](response: PromotionResponse) in
                      self?.view?.finishLoading()
                    // Get Data From Here
                  },
                  onError: { (err) in
                    self.view?.finishLoading()
                      let errMsg = JSONUtil.parseError(err.localizedDescription)
                      self.view?.showErrorView?(title: "", message: errMsg)
                  }
                )
                .disposed(by: disposeBag)
    }
    
    func getAnnouncementsData () {
        self.view?.startLoading()
        var announcementEndPoint = DashboardEndPoint.announcements
        apiManager.getData(announcementEndPoint)
                .subscribe(
                  onNext: { [weak self](response: AnnouncementResponse) in
                    self?.view?.finishLoading()
                    
                    // Get Data From Here
                  },
                  onError: { (err) in
                    self.view?.finishLoading()
                      let errMsg = JSONUtil.parseError(err.localizedDescription)
                      self.view?.showErrorView?(title: "", message: errMsg)
                  }
                )
                .disposed(by: disposeBag)
    }
    
    func getNewsLetterData () {
        self.view?.startLoading()
        var newsLetterEndPoint = DashboardEndPoint.newsletters
        apiManager.getData(newsLetterEndPoint)
                .subscribe(
                  onNext: { [weak self](response: NewsLetterResponse) in
                    self?.view?.finishLoading()
                    
                    // Get Data From Here
                  },
                  onError: { (err) in
                    self.view?.finishLoading()
                      let errMsg = JSONUtil.parseError(err.localizedDescription)
                      self.view?.showErrorView?(title: "", message: errMsg)
                  }
                )
                .disposed(by: disposeBag)
    }
    
}
