//
//  EventsManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation

class EventsManager: BaseManager {
    private var modelNavUIModel: NavigationItemUIModel?
    private var modelPrecEventsUIModel: EventsUIModel?
    weak var viewControllerDelegate: EventsControllerDelegate!
    var timer: Timer?
    
    @objc private func getEventsResponseModel() {
        print("EventsManager: update model")
        if let modelNavUIModel = self.modelNavUIModel {
            if self.modelPrecEventsUIModel == nil {
                self.viewControllerDelegate?.showLoader()
            }
            EventsService.getEventsFromAPI(urlEventName: modelNavUIModel.url).onSuccess {[weak self] (response) in
                let eventsUIModel = EventsUIModel(eventsRespModel: response)
                
                if self?.modelPrecEventsUIModel != eventsUIModel {
                    self?.modelPrecEventsUIModel = eventsUIModel
                    self?.viewControllerDelegate?.showEvents(model: eventsUIModel.events)
                    print("YES - refresh table view")
                } else {
                    print("NO - refresh table view")
                }
                
                if self?.viewControllerDelegate != nil {
                    self?.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self!, selector: #selector(self?.getEventsResponseModel), userInfo: nil, repeats: false)
                } else {
                    self?.timer = nil
                }

            }.onFailure {[weak self] (error) in
                self?.viewControllerDelegate.showAlert(errorMessage: "No data availables")
            }
            self.viewControllerDelegate?.hideLoader()
        }
    }
    
}


extension EventsManager: EventsManagerDelegate {
    func viewControllerDidLoad() {
    }
    
    func setModel(model: NavigationItemUIModel) {
        self.modelNavUIModel = model
        self.getEventsResponseModel()
    }
}
