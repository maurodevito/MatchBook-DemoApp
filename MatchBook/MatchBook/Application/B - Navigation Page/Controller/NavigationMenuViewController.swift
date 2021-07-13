//
//  NavigationMenuViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import UIKit

class NavigationMenuViewController: BaseViewController<NavigationMenuManager> {

    public static func storyboardInstance() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        return (storyboard.instantiateViewController(withIdentifier: "navigationStoryboardId") as? UINavigationController)!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        self.navigationItem.rightBarButtonItem = {
            UIBarButtonItem(title: "Close", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.closeNavigationMenuViewController))
        }()
        self.manager.viewControllerDelegate = self
        self.manager.viewControllerDidLoad()
    }
    
    
    @objc private func closeNavigationMenuViewController() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight // kCATransitionFromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }

}


extension NavigationMenuViewController: NavigationMenuControllerDelegate {
    func gotoEventPage() {
        print("goto event page")
    }
    
    
}
