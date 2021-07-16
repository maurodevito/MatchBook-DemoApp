//
//  EventsViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import UIKit


class EventsViewController: BaseViewController<EventsManager> {
    @IBOutlet weak var tableView: UITableView!
    private var model: [EventSingleUIModel] = [EventSingleUIModel]()
    private let cellIdentifier = "EventsTableViewCellIdentifier"
    let rowHeight: CGFloat = 85
    
    
    public static func storyboardInstance() -> EventsViewController {
        let storyboard = UIStoryboard(name: "Events", bundle: nil)
        let vc = (storyboard.instantiateViewController(withIdentifier: "eventsStoryboardId") as? EventsViewController)!
        return vc
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        self.manager.viewControllerDelegate = self
        self.manager.viewControllerDidLoad()
                
    }
    
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totRunner = self.model[indexPath.row].runners.count
        let totRowHeight: CGFloat = rowHeight + (CGFloat(40) * CGFloat(totRunner))
        return totRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? EventTableViewCell
        cell?.setup(event: self.model[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
}


extension EventsViewController: EventsControllerDelegate {
    func showAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (retry) in
            self.manager.viewControllerDidLoad()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            // do something
        }
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setModel(model: NavigationItemUIModel) {
        self.title = model.name
        self.manager.setModel(model: model)
    }
    
    func setEventsModel(model: [EventSingleUIModel]) {
        self.model = model
        self.tableView.reloadData()
    }
}
