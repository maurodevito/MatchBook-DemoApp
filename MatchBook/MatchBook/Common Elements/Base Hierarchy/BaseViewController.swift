//
//  BaseViewController.swift
//  MatchBook
//
//  Created by Mauro De Vito on 13/07/2021.
//

import UIKit


protocol BaseControllerDelegate: class {
    func showLoader()
    func hideLoader()
    
}



class BaseViewController <T: BaseManager>: UIViewController, BaseControllerDelegate {
    
    var manager: T
    
    required init(mng: T) {
        manager = mng
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        manager = T()
        super.init(coder: aDecoder)
    }
    
    func showLoader() {
        // TODO: showLoader
    }
    
    func hideLoader() {
        // TODO: hideLoader
    }
}


