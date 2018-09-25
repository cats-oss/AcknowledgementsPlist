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

//final class NavigationController: UINavigationController {
//
//    var rootViewController: UIViewController? {
//        return viewControllers.first
//    }
//
//    override init(rootViewController: UIViewController) {
//        super.init(navigationBarClass: TopAttachedNavigationBar.self, toolbarClass: nil)
//        viewControllers = [rootViewController]
//    }
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
//final class TopAttachedNavigationBar: UINavigationBar {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        delegate = self
//        print(self.barPosition)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
//
//extension TopAttachedNavigationBar: UINavigationBarDelegate {
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        return .topAttached
//    }
//}
