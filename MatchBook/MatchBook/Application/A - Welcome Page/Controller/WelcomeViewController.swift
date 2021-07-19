//
//  WelcomeViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import UIKit

class WelcomeViewController: BaseViewController<WelcomeManager> {
    
    public static func storyboardInstance() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let navigationController = (storyboard.instantiateViewController(withIdentifier: "welcomeStoryboardId") as? UINavigationController)!
        return navigationController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Matchbook"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openMenu))
        
        self.manager.viewControllerDelegate = self
        self.manager.viewControllerDidLoad()

    }
    

    @objc private func openMenu() {
        self.manager.openMenu()
    }
}

extension WelcomeViewController: NavigationSelectionDelegate {
    func selectedItem(_ item: NavigationItemUIModel) {
        let eventVC = EventsViewController.storyboardInstance()
        self.navigationItem.backButtonTitle = "Home"
        eventVC.setModel(model: item)
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
}

extension WelcomeViewController: WelcomeControllerDelegate {
    func openNavigationPage() {
        let navVC = NavigationMenuViewController.storyboardInstance()
        if let rootNavVC = navVC.viewControllers[0] as? NavigationMenuViewController {
            rootNavVC.selectionDelegate = self
        }
        navVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(navVC, animated: false)
    }

}

