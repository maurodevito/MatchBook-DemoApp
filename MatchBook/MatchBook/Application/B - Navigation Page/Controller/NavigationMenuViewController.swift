//
//  NavigationMenuViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import UIKit

protocol NavigationSelectionDelegate {
    func selectedItem(_ item: NavigationItemUIModel)
}

class NavigationMenuViewController: BaseViewController<NavigationMenuManager> {
    private var model: [NavigationItemUIModel] = [NavigationItemUIModel]()
    @IBOutlet weak var tableView: UITableView!
    private let cellIdentifier = "NavigationMenuTableViewCellIdentifier"
    var selectionDelegate: NavigationSelectionDelegate?
    
    public static func storyboardInstance() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        return (storyboard.instantiateViewController(withIdentifier: "navigationStoryboardId") as? UINavigationController)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.closeNavigationMenuViewController))

        let nib = UINib(nibName: "NavigationMenuTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        self.manager.viewControllerDelegate = self
        self.manager.viewControllerDidLoad()
    }
    
    
    @objc private func closeNavigationMenuViewController() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight // kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
    }
}


extension NavigationMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? NavigationMenuTableViewCell
        cell?.setupCell(item: self.model[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectionDelegate?.selectedItem(self.model[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.closeNavigationMenuViewController()
    }
    
}


extension NavigationMenuViewController: NavigationMenuControllerDelegate {
    func showTable(model: NavigationUIModel) {
        self.model = model.items
        self.tableView.reloadData()
    }
    
    func showAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (retry) in
            self.manager.viewControllerDidLoad()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            self.closeNavigationMenuViewController()
        }
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

}
