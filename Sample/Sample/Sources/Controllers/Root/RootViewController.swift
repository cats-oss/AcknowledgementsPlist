//
//  RootViewController.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/21.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit
import NSObject_Rx

final class RootViewController: UIViewController, Storyboardable {

    class func make() -> RootViewController {
        let viewController = RootViewController.makeFromStoryboard()
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationController = UINavigationController(rootViewController: LicenseViewController.make())
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
    }
}
