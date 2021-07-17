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
            let service = EventsService()
            service.getEventsFromAPI(urlEventName: modelNavUIModel.url).onSuccess { (response) in
                let eventsUIModel = EventsUIModel(eventsRespModel: response)
                
                if self.modelPrecEventsUIModel != eventsUIModel {
                    self.modelPrecEventsUIModel = eventsUIModel
                    self.viewControllerDelegate?.setEventsModel(model: eventsUIModel.events)
                    print("YES - refresh table view")
                } else {
                    print("NO - refresh table view")
                }
                
                if self.viewControllerDelegate != nil {
                    self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.getEventsResponseModel), userInfo: nil, repeats: false)
                } else {
                    self.timer = nil
                }

            }.onFailure { (error) in
                self.viewControllerDelegate.showAlert(errorMessage: "No data availables")
            }
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
