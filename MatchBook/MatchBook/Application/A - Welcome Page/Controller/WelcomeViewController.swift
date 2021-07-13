//
//  WelcomeViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import UIKit

class WelcomeViewController: BaseViewController<WelcomeManager> {

//    public static func storyboardInstance() -> WelcomeViewController {
//        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
//        return (storyboard.instantiateViewController(withIdentifier: "welcomeStoryboardId") as? WelcomeViewController)!
//    }
    
    public static func storyboardInstance() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let navigationController = (storyboard.instantiateViewController(withIdentifier: "welcomeStoryboardId") as? UINavigationController)!
        return navigationController
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Matchbook"
        self.navigationItem.leftBarButtonItem = {
            UIBarButtonItem(title: "Menu", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.openMenu))
        }()
        
        self.manager.viewControllerDelegate = self
        self.manager.viewControllerDidLoad()

    }
    

    @objc private func openMenu() {
        self.manager.openMenu()
    }
}

extension WelcomeViewController: WelcomeControllerDelegate {
    func openNavigationPage() {

        
        let navVC = NavigationMenuViewController.storyboardInstance()
        // !! NavigationMenuViewController is a MENU and not a UINavigationViewController
        navVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(navVC, animated: false)
    }

}

