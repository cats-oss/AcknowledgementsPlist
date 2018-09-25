//
//  LicenseViewController.swift
//  Sample
//
//  Created by Takuma Horiuchi on 2018/09/21.
//  Copyright © 2018年 Takuma Horiuchi. All rights reserved.
//

import UIKit

final class LicenseViewController: UIViewController, Storyboardable {

    class func make() -> LicenseViewController {
        let viewController = LicenseViewController.makeFromStoryboard()
        return viewController
    }

    @IBOutlet private weak var tableView: UITableView!

    private var settingsButtonItem: UIBarButtonItem {
        let item = UIBarButtonItem(title: "Settings", style: .plain, target: nil, action: nil)
        navigationItem.setRightBarButton(item, animated: true)
        return item
    }

    private lazy var dataSource: LicenseViewDataSource = {
        .init(viewModel: viewModel)
    }()

    private lazy var viewModel: LicenseViewModel = {
        .init(settingsTap: settingsButtonItem.rx.tap)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configure(tableView: tableView)
    }
}
