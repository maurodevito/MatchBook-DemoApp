//
//  EventsManager.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import Foundation
import  Combine

class EventsManager: BaseManager {
    private var modelNavUIModel: NavigationItemUIModel?
    private var modelPrecEventsUIModel: EventsUIModel?
    weak var viewControllerDelegate: EventsControllerDelegate!
    
    var observer: AnyCancellable?
    
    @objc private func getEventsResponseModel() {
        print("EventsManager: update model")
        if let modelNavUIModel = self.modelNavUIModel {
            if self.modelPrecEventsUIModel == nil {
                self.viewControllerDelegate?.showLoader()
            }
            observer = EventsService.getEventsFromAPI(urlEventName: modelNavUIModel.url)
                .receive(on: DispatchQueue.main)
                .retry(3)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print(error)
                        self?.viewControllerDelegate.hideLoader()
                        self?.viewControllerDelegate.showAlert(errorMessage: "No data availables")
                    }
                },
                      receiveValue: { [weak self] (response) in
                            let eventsUIModel = EventsUIModel(eventsRespModel: response)
                            if self?.modelPrecEventsUIModel != eventsUIModel {
                                self?.modelPrecEventsUIModel = eventsUIModel
                                self?.viewControllerDelegate?.showEvents(model: eventsUIModel.events)
                                print("YES - refresh table view")
                            } else {
                                print("NO - refresh table view")
                            }
                        }
                )
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
