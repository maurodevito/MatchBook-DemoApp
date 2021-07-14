//
//  EventViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import UIKit


class EventsViewController: BaseViewController<EventManager> {
    private var modelNavUIModel: NavigationUIModel?
    
    public static func storyboardInstance() -> EventsViewController {
        let storyboard = UIStoryboard(name: "Events", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "eventStoryboardId") as? EventsViewController)!
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Matchbook"
        self.manager.viewControllerDelegate = self
        self.manager.viewControllerDidLoad()

    }
}



extension EventsViewController: EventControllerDelegate {
    func setModel(model: NavigationUIModel) {
        self.modelNavUIModel = model
        self.title = model.name
    }
}
